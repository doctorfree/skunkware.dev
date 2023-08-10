/***************************************************************
 *   NAME
 *       STE - Simple Text Editor
 *
 *   SYNOPSIS
 *       ste [ filename ]
 *
 *   DESCRIPTION
 *       STE is a trivial editor program for UNIX illiterates
 *       who want an easy way to enter simple text into a mail
 *       file or other text file without learning anything at all.   
 *
 *       STE uses only the ASCII keyboard, the cursor keys,
 *       and a few other keys common on PC compatible and
 *       wyse60's. Its primary goal is to be easy to learn
 *       and use. Power users should migrate to vi or emacs.
 *
 *       If STE_LAME_KEYBOARD is present in the environment,
 *       the bottom-line help will reflect the CTRL+key combos
 *       instead of the function key shortcuts.
 *
 *   AUTHOR
 *       Originally written by Gene Olson  (gene@zeno.mn.org)
 *       Other minor hacks by Robert Lipe (robertl@dgii.com)
 *       HP-UX mods by Robert D. Gronlunc (bob@col.hp.com)
 *       Search mode by Peter Wolfe (wolfe@teloseng.com)
 *
 *   BUGS
 *       The backspace function is unavailable on adm3a, tvi925,
 *       and native wyse60 terminals.  These terminals produce
 *       backspace for both the backspace and left cursor keys.
 *       Without reprogramming the keyboard, its not possible for
 *       us to distinguish between the two.
 *
 ****************************************************************/

/****************************************************************
 *   BUILDING & MISC
 *
 * For "normal" systems, just execute
 *	cc -o ste ste.c -l tinfo
 * For HP-UX version 9.03
 *   edit all occurrences of "tigetstr(id)" to "tgetstr(id,null)"
 *      cc -o ste ste.c -D-l
 * 
 * Thank you to Peter Wolfe (wolfe@teloseng.com) for the search code
 *   
 ****************************************************************/

/****************************************************************
 *    GETTING
 ****************************************************************/

#if !defined(lint)
char version[] = "@(#)ste.c  1.5  3/8/94" ;
#endif

#include <fcntl.h>
#include <stdio.h>
#include <curses.h>
#include <signal.h>
#include <ctype.h>
#include <termio.h>
#include <errno.h>
#include <stdlib.h>

extern int errno ;
extern char *sys_errlist[] ;

extern void *malloc() ;
extern void *realloc() ;
extern void free() ;

extern char *strcpy() ;
extern char *tigetstr() ;

extern void exit() ;
extern void perror() ;

#define ctrl(x)  ((x) & 0x1f)

#define assert(x) if (!(x)) *(int *)1 = 5 ;

/*
 *  Keys to substitute for the Function Keys, Cursor Keys
 *  and like that when they are not available.
 */

#define SUB_LEFT        ctrl('b')
#define SUB_RIGHT       ctrl('f')
#define SUB_DOWN        ctrl('n')
#define SUB_UP          ctrl('p')

#define SUB_HOME        ctrl('a')
#define SUB_NPAGE       ctrl('d')
#define SUB_PPAGE       ctrl('u')
#define SUB_END         ctrl('e')

#define SUB_IC          ctrl('t')

#define SUB_F1          ctrl('[')
#define SUB_F2          ctrl('y')
#define SUB_F3          ctrl('x')
#define SUB_F4          ctrl('w')
#define SUB_F5          ctrl('g')
#define SUB_F6          ctrl('z')
#define SUB_F7          ctrl('o')

#define SUB_LIT         ctrl('v')

/*
 *  Line structure.
 *
 *  Each file is said to consist of a series of lines.
 *  Each line is represented by a LINE structure.  All
 *  lines except the last one, pointed to by fline,
 *  are terminted by a newline.
 */

typedef struct line LINE ;

struct line {
    LINE*       l_next ;                /* Next line */
    LINE*       l_last ;                /* Last line */
    char        l_data[1] ;             /* Line data */
} ;

LINE boundary[1] ;                      /* File headers */
LINE *curline ;                         /* Current line pointer */

/*
 *  Row and column variables.
 */

#define MAXLINE 512                     /* Max input file line size */

int irow ;                              /* Input row */
int icol ;                              /* Input column */

int tcol ;                              /* Target column */

int nrow ;                              /* Number of rows */
int ncol ;                              /* Number of columns */

/*
 *  Miscellaneous.
 */

int newline_fix ;                       /* Fix newline mapping */
int backspace_fix ;                     /* Fix backspace mapping */

int repaint ;                           /* Repaint the screen */

char *filename ;                        /* Default file name */
char *answer ;                          /* Answer buffer */
char *errmsg ;                          /* Error message */

int overtype_mode ;                     /* 0 = insert mode */

#define WRAP_MARGIN 65                  /* Wrap column */
#define WRAP_DAMMIT 72                  /* Beep column */
#define FILTER_NAME "fmt"               /* Reformatting program */

int start_row;                       /* Search start row */
int searched_row;                    /* Searched row */
int start_col;                       /* Search start column */
char *string_name;                   /* Searched string name */


/***************************************************************
 ***  Traverse forward or backward a number of lines.
 ***************************************************************/

LINE *
traverse(lp, n)
register LINE *lp ;
register int n ;
{
    /*
     *  Go backwards.
     */

    while (n < 0 && lp->l_last != boundary)
    {
        assert(lp->l_last->l_next == lp) ;
        lp = lp->l_last ;
        n++ ;
    }

    /*
     *  Go forwards.
     */

    while (n > 0 && lp->l_next != boundary)
    {
        assert(lp->l_next->l_last == lp) ;
        lp = lp->l_next ;
        n-- ;
    }

    return(lp) ;
}



/***************************************************************
 ***  Create and insert a new line.
 ***************************************************************/

LINE *
create_line(np, str)
register LINE *np ;
char *str ;
{
    register LINE *lp ;
    register LINE *pp ;

    lp = (LINE *) malloc((int)&((LINE *)0)->l_data[strlen(str)+1]) ;
    if (lp == 0)
    {
        errmsg = "Out of memory" ;
        return(0) ;
    }

    assert(np->l_last->l_next == np) ;
    pp = np->l_last ;

    lp->l_next = np ;
    lp->l_last = pp ;

    pp->l_next = lp ;
    np->l_last = lp ;

    (void) strcpy(lp->l_data, str) ;

    return(lp) ;
}



/***************************************************************
 ***  Resize a line.
 ***************************************************************/

LINE *
resize_line(lp, n)
register LINE *lp ;
register int n ;
{
    register LINE *rp ;

    if (n >= ncol)
    {
        errmsg = "Line too long" ;
        return(0) ;
    }

    assert(lp->l_last->l_next == lp) ;
    assert(lp->l_next->l_last == lp) ;

    n = (n + 8) & ~7 ;

    rp = (LINE *)realloc((void *)lp, (int)&((LINE *)0)->l_data[n]) ;
    if (lp == 0)
    {
        errmsg = "Out of memory" ;
        return(0) ;
    }

    rp->l_last->l_next = rp ;
    rp->l_next->l_last = rp ;

    return(rp) ;
}



/***************************************************************
 ***  Destroy line.
 ***************************************************************/

destroy_line(lp)
register LINE *lp ;
{
    register LINE *pp ;
    register LINE *np ;

    pp = lp->l_last ;
    np = lp->l_next ;

    assert(lp != boundary && pp->l_next == lp && np->l_last == lp) ;

    pp->l_next = np ;
    np->l_last = pp ;

    free((void *)lp) ;
}



/***************************************************************
 ***  Delete a line.
 ***************************************************************/

delete_line(lp)
register LINE *lp ;
{
    register LINE *pp ;
    register LINE *np ;

    pp = lp->l_last ;
    np = lp->l_next ;

    if (np != boundary) curline = np ;
    else if (pp != boundary)
    {
        curline = pp ;
        if (--irow < 0) irow = nrow / 4 ;
    }
    else if (lp->l_data[0])
    {
        lp->l_data[0] = 0 ;
        icol = 0 ;
        repaint = 1 ;
        return(1) ;
    }
    else
    {
        errmsg = "Nothing to delete" ;
        return(0) ;
    }

    destroy_line(lp) ;

    icol = 0 ;
    repaint = 1 ;
    return(1) ;
}



/***************************************************************
 ***  Delete a character.
 ***************************************************************/

delete_char()
{
    register int n ;
    register int i ;
    register LINE *lp ;
    register char *cp ;

    lp = curline ;
    n = strlen(lp->l_data) ;
    if (icol < n)
    {
        cp = lp->l_data + icol ;
        while (cp[0] = cp[1]) cp++ ;
        move(irow, icol) ;
        delch() ;
    }
    else
    {
        if (lp->l_next == boundary)
        {
            errmsg = "At end-of-file" ;
            return(0) ;
        }

        i = strlen(lp->l_next->l_data) ;
        lp = resize_line(lp, n + i) ;
        if (lp == 0) return(0) ;

        (void) strcpy(lp->l_data + n, lp->l_next->l_data) ;
        destroy_line(lp->l_next) ;

        curline = lp ;
        repaint = 1 ;
        idlok(stdscr, 1) ;
    }

    tcol = icol ;
    return(1) ;
}



/**************************************************************
 ***  split_line
 **************************************************************/

split_line()
{
    register LINE *lp = curline ;
    register LINE *np ;

    np = create_line(lp->l_next, lp->l_data + icol) ;
    if (np == 0) return(0) ;

    (void) strcpy(np->l_data, lp->l_data + icol) ;
    lp->l_data[icol] = 0 ;

    curline = np ;

    if (++irow == nrow) irow -= nrow / 4 ;

    tcol = icol = 0 ;
    repaint = 1 ;

    return(1) ;
}



/***************************************************************
 ***  Insert a printable character.
 ***************************************************************/

insert_char(c)
int c ;
{
    register int n ;
    register LINE *lp ;
    register char *ip ;
    register char *cp ;

    lp = curline ;
    n = strlen(lp->l_data) ;

    if (overtype_mode && tcol < strlen(lp->l_data))
    {
        lp->l_data[tcol]=c;
        addch(c);
        tcol = ++icol ; 
        return(1);
    }

    if (tcol > WRAP_MARGIN)
    {
        if ((n == tcol) && (isspace(c))) 
        {
            (void) split_line() ;
            return(1);
        }
        else if (tcol > WRAP_DAMMIT) beep() ;
    }

    lp = resize_line(lp, n + 1) ;
    if (lp == 0) return(0) ;
    curline = lp ;

    ip = lp->l_data + icol ;
    cp = lp->l_data + n ;
    for (; cp >= ip ; --cp) cp[1] = cp[0] ;
    ip[0] = c ;

    move(irow, icol) ;
    insch(c) ;

    tcol = ++icol ;

    return(1) ;
}



/**************************************************************
 ***  Move cursor up.
 **************************************************************/

cursor_up()
{
    register LINE *lp = curline ;
    register int n ;

    if (lp->l_last == boundary)
    {
        errmsg = "At start-of-file" ;
        return(0) ;
    }

    curline = lp = lp->l_last ;

    if (--irow < 0)
    {
        irow += nrow / 4 + 1 ;
        repaint = 1 ;
    }

    n = strlen(lp->l_data) ;
    icol = tcol < n ? tcol : n ;

    return(1) ;
}



/**************************************************************
 ***  Move cursor down.
 **************************************************************/

cursor_down()
{
    register LINE *lp = curline ;
    register int n ;

    if (lp->l_next == boundary)
    {
        errmsg = "At end-of-file" ;
        return(0) ;
    }

    curline = lp = lp->l_next ;

    if (++irow == nrow)
    {
        irow -= nrow / 4 ;
        repaint = 1 ;
    }

    n = strlen(lp->l_data) ;
    icol = tcol < n ? tcol : n ;

    return(1) ;
}



/**************************************************************
 ***  Move cursor left.
 **************************************************************/

cursor_left()
{
    register LINE *lp = curline ;

    if (icol > 0) icol-- ;
    else if (lp->l_last == boundary)
    {
        errmsg = "At start-of-file" ;
        return(0) ;
    }
    else
    {
        curline = lp = lp->l_last ;
        icol = strlen(lp->l_data) ;

        if (--irow < 0)
        {
            irow++ ;
            repaint = 1 ;
        }
    }

    tcol = icol ;
    return(1) ;
}



/**************************************************************
 ***  Move cursor right.
 **************************************************************/

cursor_right()
{
    register LINE *lp = curline ;
    register int n ;

    n = strlen(lp->l_data) ;

    if (icol < n) icol++ ;
    else if (lp->l_next == boundary)
    {
        errmsg = "At end-of-file" ;
        return(0) ;
    }
    else
    {
        curline = lp = lp->l_next ;
        icol = 0 ;

        if (++irow == nrow)
        {
            irow-- ;
            repaint = 1 ;
        }
    }

    tcol = icol ;
    return(1) ;
}


/**************************************************************
 ***  Move cursor right but go to the start of the if the
 ***  end of the file. Return 0 when reached the character
 ***  where the search started at.
 **************************************************************/

cursor_cont()
{
    register LINE *lp = curline ;
    register int n ;

    n = strlen(lp->l_data) ;

    if (icol < n)
    {
        icol++ ;
    }
    else if (lp->l_next == boundary)
    {
       	/* set on the begining of the file */
       	curline = boundary->l_next;
    	irow = 0;
	icol = 0;
	tcol = icol;
	repaint = 1;
	searched_row = 0;

	/* check if reached the start of the search */
	if( searched_row == start_row && icol == start_col )
	    return(0) ;
        return(1);
    }
    else
    {
        curline = lp = lp->l_next ;
	icol = 0 ;
	searched_row++;

	if (++irow == nrow)
	{
	    irow-- ;
	    repaint = 1 ;
	}
    }

    tcol = icol ;

    /* check if reached the start of the search */
    if( searched_row == start_row && icol == start_col )
	return(0);
    return(1) ;
}



/***************************************************************
 ***  Repeat a command several times.
 ***************************************************************/

/*VARARGS2*/
repeat(n, cmd, param)
int (*cmd)() ;
int n ;
int param ;
{
    while (--n >= 0) if (!(*cmd)(param)) return(0) ;

    return(1) ;
}



/***************************************************************
 ***  Read file into editor.
 ***************************************************************/

read_file(fname)
char *fname ;
{
    register FILE *edfile ;
    register char *sp ;
    register int d ;
    register int c ;

    char sbuf[MAXLINE+1] ;
    char dbuf[MAXLINE+1] ;

    edfile = fopen(fname, "r") ;
    if (edfile == 0)
    {
        if (errno == ENOENT) errmsg = "New File" ;
        else errmsg = sys_errlist[errno] ;
        return(0) ;
    }

    while (fgets(sbuf, MAXLINE, edfile) != 0)
    {
        for (sp = sbuf, d = 0 ; (c = *sp) && d < MAXLINE ; sp++)
        {
            if (0x20 <= c && c < 0x7f) dbuf[d++] = c ;
            else if (c == '\t')
            {
                for (;;)
                {
                    dbuf[d++] = ' ' ;
                    if (d == MAXLINE || (d & 0x7) == 0) break ;
                }
            }
        }
        dbuf[d] = 0 ;

        if (!create_line(curline, dbuf)) break ;
    }

    (void) fclose(edfile) ;

    icol = 0 ;

    return(1) ;
}



/***************************************************************
 ***  Write out edit file.
 ***************************************************************/

write_file(fname)
char *fname ;
{
    register FILE *edfile ;
    register LINE *lp ;

    edfile = fopen(fname, "w") ;
    if (edfile == 0)
    {
        errmsg = sys_errlist[errno] ;
        return(0) ;
    }

    for (lp = boundary->l_next ; lp != boundary ; lp = lp->l_next)
    {
        (void) fputs(lp->l_data, edfile) ;
        (void) fputc('\n', edfile) ;
    }

    (void) fclose(edfile) ;

    return(1) ;
}



/**********************************************************************
 *  Test if a line contains printable data.
 **********************************************************************/

printable(lp)
LINE *lp ;
{
    register char *p ;

    if (lp == boundary) return(0) ;

    for (p = lp->l_data ; *p ; p++)
    {
        if (!isspace(*p)) return(1) ;
    }

    return(0) ;
}



/**********************************************************************
 *  Reformat Paragraph.
 **********************************************************************/

reformat_paragraph()
{
    register LINE *lp ;
    LINE *p0 ;
    LINE *p1 ;
    FILE *pfile ;
    char *tmp ;
    int rtn ;
    static char cmd[200] ; /* Also use this for error return */

    /*
     *  Find the limits of the current paragraph.
     */

    p0 = curline ;

    while (!printable(p0))
    {
        p0 = p0->l_last ;

        if (p0 == boundary)
        {
            errmsg = "No paragraph under or above cursor" ;
            return(0) ;
        }

        if (printable(p0)) break ;
    }

    for (; printable(p0->l_last) ; p0 = p0->l_last) ;

    p1 = curline ;
    while (printable(p1) && (p1 = p1->l_next) != boundary) irow++ ;

    if (irow >= nrow) irow = nrow - 1 ;

    /*
     *  Create a temp file to hold the output from the
     *  format filter program.
     */

    rtn = 0 ;

    tmp = tempnam((char *)0, "ste.") ;

    if (tmp == 0)
    {
        errmsg = "Cannot create temp file" ;
        return(0) ;
    }

    /*
     *  Pipe the contents of the current paragraph to
     *  the print filter.
     */

    (void) sprintf(cmd, "%s >%s", FILTER_NAME, tmp) ;

    errno = 0 ; 
    pfile = popen(cmd, "w") ;

    if (pfile == NULL || errno )
    {
	strcat( cmd, sys_errlist[errno]);
	errmsg = cmd ; 
	
        goto done ;
    }

    for (lp = p0 ; lp != p1 ; lp = lp->l_next)
    {
        (void) fputs(lp->l_data, pfile) ;
        (void) fputc('\n', pfile) ;
    }

    errno = 0 ;

    if (pclose(pfile) != 0)
    {
        errmsg = errno ? sys_errlist[errno] : "Formatting command failed" ;
        goto done ;
    }

    /*
     *  Discard the original copy of the reformatted paragraph.
     */

    p0->l_last->l_next = p1 ;
    p1->l_last = p0->l_last ;

    while (p0 != p1)
    {
        lp = p0->l_next ;
        free((void *)p0) ;
        p0 = lp ;
    }

    curline = p1 ;

    (void) read_file(tmp) ;

    if (boundary->l_next == boundary)
        curline = create_line(boundary, "") ;
    else if (curline == boundary)
        curline = boundary->l_last ;

    icol = 0 ;

    repaint = 1 ; 

    rtn = 1 ;

done:
    (void) unlink(tmp) ;
    free((void *)tmp) ;

    return(rtn) ;
}



/***************************************************************
 ***  Paint a line on the edit screen.
 ***************************************************************/

paint_line(lp)
register LINE *lp ;
{
    register char *cp ;
    register int n ;

    assert(lp->l_last->l_next == lp && lp->l_next->l_last == lp) ;

    for (cp = lp->l_data, n = ncol ; *cp && n-- ; cp++)
        addch(*cp) ;
}



/***************************************************************
 ***  Display menu item at bottom of screen.
 ***************************************************************/

menu_item(sub_char, fun_key, tio_attr, desc)
int sub_char ;
char *fun_key ;
char *tio_attr ;
char *desc ;
{
    if (tigetstr(tio_attr) && !getenv("STE_LAME_KEYBOARD") )
        addstr(fun_key) ;
    else if (sub_char)
        (void) printw("^%c", sub_char + 'A' - 1) ;
    else return ;

    addstr(desc) ;
}



/***************************************************************
 ***  Paint the edit screen.
 ***************************************************************/

paint_screen()
{
    register int r ;
    register LINE *lp ;

    erase() ;

    /*
     *  Display the main portion of the screen.
     */

    lp = traverse(curline, -irow) ;

    irow = -1 ;

    for (r = 0 ; r < nrow ; r++)
    {
        move(r, 0) ;

        if (lp == boundary)
        {
            addch('~') ;
        }
        else
        {
            paint_line(lp) ;

            if (lp == curline) irow = r ;
            lp = lp->l_next ;
        }
    }

    assert(irow >= 0) ;

    /*
     * Display bottom line error message or mini-menu.
     */

    move(nrow, 0) ;

    if (errmsg)
    {
        standout() ;
        addstr("  ") ;
        addstr(errmsg) ;
        addstr("  ") ;
        standend() ;
    }
    else
    {
        menu_item(SUB_F1, "F1", "kf1", "=Help ") ;
        menu_item(SUB_F2, "F2", "kf2", "=Save/Quit ") ;
        menu_item(SUB_F3, "F3", "kf3", "=Abort ") ;
        menu_item(SUB_F4, "F4", "kf4", "=Save ") ;
        menu_item(SUB_F5, "F5", "kf5", "=Ins/File ") ;
        menu_item(SUB_F6, "F6", "kf6", "=Del/Line ") ;
        menu_item(SUB_F7, "F7", "kf7", "=Reformat") ;

        move(nrow, ncol - 4) ;
        addstr((overtype_mode ? "REP" : "INS"));
    }
}



/**************************************************************
 ***  Display one Help Item.
 **************************************************************/

help_item(sub_char, key_name, tio_attr, key_desc, key_mnemonic)
int sub_char ;
char *key_name ;
char *tio_attr ;
char *key_desc ;
char *key_mnemonic ;
{
    addstr("    ") ;
    if (sub_char)
        (void) printw("^%c", sub_char + 'A' - 1) ;
    else
        addstr("  ") ;

    if (key_mnemonic)
	{
	/* A little gross, but it keeps our formatting pretty */
	char tmp_buffer [20] ;
	tmp_buffer[0] = '(' ;
	tmp_buffer[1] = 0 ;
	strncat (tmp_buffer, key_mnemonic, sizeof(tmp_buffer) - 3 );
	strncat (tmp_buffer, ")");

	(void) printw("  %-12s", tmp_buffer);
	}
    else
        (void) printw("  %-12s", "");

    (void) printw("  %-13s",
        (tio_attr == 0 || tigetstr(tio_attr)) ? key_name : "") ;

    addstr(key_desc) ;
    addch('\n') ;
}



/***************************************************************
 ***  Display Help Screen.
 ***************************************************************/

help_display()
{
    char help_hdr[]="Help Screen" ;
    int nspcs = ((COLS - strlen(help_hdr)) / 2) -1 ;
    int n ;

    erase() ;

    standout();
    for(n=0;n<nspcs;n++)
	addstr(" ");
    addstr(help_hdr);
    for(n=0;n<nspcs;n++)
	addstr(" ");
    addstr("\n");
    standend();

    help_item(SUB_UP,    "Up Arrow",    "kcuu1",  "Move cursor up", "Previous") ;
    help_item(SUB_DOWN,  "Down Arrow",  "kcud1",  "Move cursor down", "Next" ) ;
    help_item(SUB_LEFT,  "Left Arrow",  "kcub1",  "Move cursor left", "Back") ;
    help_item(SUB_RIGHT, "Right Arrow", "kcuf1",  "Move cursor right", "Forward") ;

    addstr("\n") ;

    if (!backspace_fix)
        help_item('\b',"Backspace","kbs","Delete the char left of the cursor", NULL) ;

    help_item(0,      "Delete", (char *)0, "Delete the char under the cursor", NULL) ;
    help_item(SUB_IC, "Insert", "kich1",   "Toggle insert/replace mode", "Toggle") ;

    addstr("\n") ;

    help_item(SUB_HOME,  "Home",      "khome", "Go to start of file", NULL) ;
    help_item(SUB_END,   "End",       "kend",  "Go to end of file", "End" ) ;
    help_item(SUB_PPAGE, "Page up",   "kpp",   "Go up a screen", "Up" ) ;
    help_item(SUB_NPAGE, "Page down", "knp",   "Go down a screen", "Down" ) ;

    addstr("\n") ;

    help_item(SUB_F1,    "F1",    "kf1",   "Display this HELP screen", "Escape" ) ;
    help_item(SUB_F2,    "F2",    "kf2",   "Save changes and quit", NULL) ;
    help_item(SUB_F3,    "F3",    "kf3",   "Quit without saving changes", NULL) ;
    help_item(SUB_F4,    "F4",    "kf4",   "Write the edit buffer to a file", NULL) ;
    help_item(SUB_F5,    "F5",    "kf5",   "Insert a file above the cursor", NULL) ;
    help_item(SUB_F6,    "F6",    "kf6",   "Delete current line", NULL) ;
    help_item(SUB_F7,    "F7",    "kf7",   "Reformat the current paragraph", NULL) ;

    help_item(0,         "F8",    "kf8",   "Search a string", NULL) ;
    help_item(0,         "F9",    "kf9",   "Continue searching", NULL) ;

}



/***************************************************************
 ***  Prompt for user response.
 ***************************************************************/

prompt(str)
char *str ;
{
    register int fchar ;
    register int nchar ;
    register int c ;

    move(LINES-1, 0) ;
    clrtoeol() ;
    addstr(str) ;

    fchar = strlen(str) ;
    nchar = 0 ;

    for (;;)
    {
        move(LINES-1, fchar + nchar) ;
        refresh() ;

        c = getch() ;

        switch(c)
        {
        case KEY_BACKSPACE:
        case '\b':
            if (nchar == 0) beep() ;
            else
            {
                answer[nchar] = 0 ;
                nchar-- ;
                move(LINES-1, fchar+nchar) ;
                addch(' ') ;
            }
            break ;
        
        case KEY_ENTER:
        case '\n':
        case '\r':
            answer[nchar] = 0 ;
            repaint = 1 ;
            return ;
        
        case ctrl('l'):
        case ctrl('r'):
            clearok(stdscr, 1) ;
            break ;
        
        case ctrl('u'):
            move(LINES-1, fchar) ;
            clrtoeol() ;
            nchar++ ;
            break ;
        
        default:
            if (c < 0x20 || c >= 0x7f) beep() ;
            else
            {
                addch(c) ;
                answer[nchar] = c ;
                nchar++ ;
                break ;
            }
        }
    }
}


/***************************************************************
 ***  Search string.
 ***************************************************************/

search_do()
{
    register int   i;
    register int   m;
    register LINE* lp;

    /* store where you were */
    lp = curline;
    searched_row = -1;
    for(lp = boundary; lp != curline; lp = lp->l_next)
    {
	searched_row++;
    }
    if(searched_row == -1)
    {
	errmsg = "No Text To Search";
	return;
    }
    start_row = searched_row;
    start_col = icol;
    m = strlen(string_name);

    /* move the cursor to the next character */
    cursor_cont();
    while(cursor_cont())
    {
	/* compare to the searched string */
	if(strncmp(&curline->l_data[icol], string_name, m) == 0)
	{
	   return; 
	}
    }
    errmsg = "Not found";
}


/***************************************************************
 ***  Edit screen.
 ***************************************************************/

edit()
{
    register int c ;
    register int n ;
    register int rtn ;

    paint_screen() ;

    for (;;)
    {
        assert(curline != boundary) ;

        /*
         *  Input a character.
         */

        move(irow, icol) ;
        refresh() ;

        idlok(stdscr, 0) ;

        c = getch() ;

        /*
         *  Process input keystroke.
         */

        repaint = (errmsg != 0) ;
        errmsg = 0 ;
        rtn = 1 ;

        switch(c)
        {
        case KEY_HELP:
        case KEY_F(1):
        case SUB_F1:
            help_display() ;
            refresh() ;
            c = getch() ;
            repaint = 1 ;
            break ;
        
        case KEY_F(2):
        case SUB_F2:
            if (filename)
            {
                prompt("Type 'y' to save changes and exit: ") ;
                if (answer[0] != 'y')
                {
                    errmsg = "Save Cancelled" ;
                    break ;
                }
                if (write_file(filename)) return ;
            }
            else
            {
                prompt("Save to file name: ") ;
                if (answer[0] && write_file(answer)) return ;
            }
            break ;
        
        case KEY_F(3):
        case SUB_F3:
            prompt("Type 'yes' to exit without saving Changes: ") ;
            if (strcmp(answer, "yes") == 0) return ;
            errmsg = "Exit not confirmed" ;
            break ;

        case KEY_F(4):
        case SUB_F4:
            if (filename)
            {
                char msg[200] ;
                (void) sprintf(msg,
                    "Type 'y' to save in file %s: ", filename) ;
                prompt(msg) ;
                if (answer[0] == 'y')
                {
                    (void) write_file(filename) ;
                    break ;
                }
            }
            prompt("Save to file name: ") ;
            if (answer[0])
            {
                if (write_file(answer) && !filename)
                {
                    filename = (char *)malloc(strlen(answer)+1) ;
                    (void) strcpy(filename, answer) ;
                }
                break ;
            }
            errmsg = "Write File Cancelled" ;
            break ;

        case KEY_F(5):
        case SUB_F5:
            prompt("Name of file to read: ") ;
            if (answer[0])
            {
                if (!read_file(answer)) break ;
                if (!filename)
                {
                    filename = (char *)malloc(strlen(answer)+1) ;
                    (void) strcpy(filename, answer) ;
                }
                if (irow < nrow/2) irow = nrow/2 ;
            }
            else errmsg = "Read File Cancelled" ;
            break ;

        case KEY_F(6):
        case SUB_F6:
        case KEY_DL:
            rtn = delete_line(curline) ;
            idlok(stdscr, 1) ;
            break ;

        case KEY_F(7):
        case SUB_F7:
            (void) reformat_paragraph();
            break;
       
	case KEY_F(8): 
            prompt("Name string to search: ") ;
            if (answer[0])
            {
                strcpy(string_name,answer);
                search_do();
            }
            else errmsg = "Search String Cancelled" ;
            break;
 
        case KEY_F(9):
            if( strlen(string_name) == 0 )
            {
                errmsg = "No String To Search";
              }
              else
            {
                search_do();
              }
            break;

        case KEY_F(10):
        case KEY_F(11):
        case KEY_F(12):
            errmsg = "That key never works!" ;
            break ;

        case KEY_UP:
        case SUB_UP:
            rtn = cursor_up() ;
            break ;

        case KEY_DOWN:
        case SUB_DOWN:
        key_down:
            rtn = cursor_down() ;
            break ;

        case KEY_LEFT:
        case SUB_LEFT:
        key_left:
            rtn = cursor_left() ;
            break ;

        case KEY_RIGHT:
        case SUB_RIGHT:
            rtn = cursor_right() ;
            break ;

        case '\b':
            if (backspace_fix) goto key_left ;
        case KEY_BACKSPACE:
            rtn = cursor_left() && delete_char() ;
            break ;
        
        case KEY_DC:
        case 0x7f:
            rtn = delete_char() ;
            break ;

        case KEY_IC:
        case SUB_IC:
            overtype_mode = 1 - overtype_mode ; 
            repaint = 1 ;
            break;
        
        case KEY_HOME:
        case SUB_HOME:
            if (curline->l_last == boundary && icol == 0)
            {
                errmsg = "Already at Start-of-file" ;
                break ;
            }
            curline = boundary->l_next ;
            irow = icol = 0 ;
            repaint = 1 ;
            break ;
        
        case KEY_END:
        case SUB_END:
            if (curline->l_next == boundary && icol == strlen(curline->l_data))
            {
                errmsg = "Already at End-of-file" ;
                break ;
            }
            curline = boundary->l_last ;
            irow = nrow - 2 ;
            icol = strlen(curline->l_data) ;
            repaint = 1 ;
            break ;

        case KEY_PPAGE:
        case SUB_PPAGE:
            if (curline->l_last == boundary)
            {
                errmsg = "At Start-of-File" ;
                break ;
            }
            curline = traverse(curline, -(nrow + irow)) ;
            irow = icol = 0 ;
            repaint = 1 ;
            break ;

        case KEY_NPAGE:
        case SUB_NPAGE:
            if (curline->l_next == boundary)
            {
                errmsg = "At End-of-File" ;
                break ;
            }
            curline = traverse(curline, nrow-irow) ;
            irow = icol = 0 ;
            repaint = 1 ;
            break ;

        case SUB_LIT:
            break ;

        case '\t':
            n = 8 - (icol % 8) ;
            rtn = repeat(n, insert_char, ' ') ;
            break ;
        
        case '\n':
            if (newline_fix) goto key_down ;
        case '\r':
            rtn = split_line() ;
            idlok(stdscr, 1) ;
            break ;
        
        case ctrl('l'):
        case ctrl('r'):
            clearok(stdscr, 1) ;
            break ;
        
        default:
            rtn = 0x20 <= c && c < 0x7f && insert_char(c) ;
            break ;
        }

        if (!rtn) beep() ;
        if (repaint || errmsg)
        {
            paint_screen() ;
        }
    }
}



/***************************************************************
 ***  Catch and ignore interrupts.
 ***************************************************************/

void
catch()
{
    (void) signal(SIGINT, catch) ;
    (void) signal(SIGQUIT, catch) ;
}



/***************************************************************
 ***  Main program.
 ***************************************************************/

main(argc, argv)
int argc ;
char **argv ;
{
    register char *key ;
    struct termio tio ;
    struct termio oldtio ;

    if (argc > 2)
    {
        (void) fprintf(stderr, "Usage: %s [ filename ]\n", argv[0]) ;
        exit(2) ;
    }

    filename = argc == 2 ? argv[1] : 0 ;

    boundary->l_next = boundary->l_last = boundary ;
    boundary->l_data[0] = 0 ;
    curline = boundary ;

    /*
     * Disable the interrupt key before calling initscr(),
     * so that an interrupt DELETE key can be used to delete
     * the character under the cursor.
     */

    if (ioctl(0, TCGETA, &oldtio) != 0)
    {
        perror("TCGETA") ;
        exit(1) ;
    }

    tio = oldtio ;
    tio.c_cc[VINTR] = 0 ;
    tio.c_lflag &= (~ISIG) ;	/* Be sure job control disabled */

    if ( ioctl(0, TCSETAW, &tio)  < 0 )
    {
	perror("TCSETA") ;
	exit(1);
    }

    (void) initscr() ;

    catch() ;

    cbreak() ;
    noecho() ;
    nonl() ;

    /* 
     * Now, the curses routines above cleverly turn ISIG back on (grrrr.) 
     * So we try to smack them off again, don't clobber oldtio. 
     */

    if (ioctl(0, TCGETA, &tio) != 0)
    {
        perror("TCGETA") ;
        exit(1) ;
    }

    tio.c_lflag &= (~ISIG) ;	/* Be sure job control disabled */

    if ( ioctl(0, TCSETAW, &tio)  < 0 )
    {
	perror("TCGETA") ;
	exit(1);
    }

    answer = (char *)malloc(COLS) ;
    string_name = (char *)malloc(COLS) ;
    strcpy(string_name, "");

    keypad(stdscr, 1) ;

    key = tigetstr("kcud1") ;
    if (key && key != (char *)-1 && strcmp(key, "\n") == 0) newline_fix++ ;

    key = tigetstr("kcub1") ;
    if (key && key != (char *)-1 && strcmp(key, "\b") == 0) backspace_fix++ ;

    ncol = COLS ;
    nrow = LINES - 1 ;

    irow = 0 ;
    icol = 0 ;

    if (filename) (void) read_file(filename) ;

    curline = boundary->l_next ;
    if (curline == boundary)
        curline = create_line(boundary, "") ;

    edit() ;

    /* If you don't have reset_shell_mode() [ I don't know of anyone
       that doesn't] , flip this around.  The justification is so that
       it won't nuke custom color sets if running from an xterm or
       color console, etc. */
#if 0
    endwin() ;
#else
    reset_shell_mode();
#endif

    (void) ioctl(0, TCSETAW, &oldtio) ;

    (void) putchar('\n') ;
    return(0) ;
}
