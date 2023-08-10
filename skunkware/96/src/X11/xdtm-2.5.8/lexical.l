%{ /*-*- Mode: C -*-*/
/**************************************************************************
 ** File     :       lexical.l                                           **
 ** Author   :       Edward Groenendaal                                  **
 ** Modified :       29/3/92 - set MAXERR to 0, put filename in error    **
 **                  messages, eddyg.					 **
 **                  18-04-92, Edward Groenendaal                        **
 **                  Added #if NeedFunctionPrototypes stuff              **
 **************************************************************************/

/* with A/UX on a macII the pre-processor tries to expand the lex input macro
 * within the X11R4 Xutil.h header file, therefore to prevent this I have 
 * defined the _XUTIL_H_ symbol for macII's, it's not needed in this file
 * anyway. Edward Groenendaal 19-04-92.. Easter day.. and I'm doing this!?!
 *
 * 20-04-92 Edward Groenendaal - I had the same problem on a Sun (SunOS4.1.1)
 * with X11R4, I therefore am going to undef _XUTIL_H_ for ALL machines.
 */

#ifdef __STDC__
#include "xdtm.h"
#endif

/* #ifdef macII */
#ifndef _XUTIL_H_
#define _XUTIL_H_
#endif
/* #endif */

#ifndef __STDC__
#include "xdtm.h" 
#endif
#include "parse.h"

/*
 * Check to see if we are using flex instead of lex.  If so, need to
 * undefine yywrap.
 */

#ifdef FLEX_SCANNER
#undef yywrap
#endif

/* I shall use the macro RETURN whenever returning a token. If DEBUG_LEX has
 * been defined then the token will be printed out, otherwise it will
 * be returned.
 */

#ifdef DEBUG_LEX

/* define the RETURN macro to print the token to be returned */
# define RETURN(token)    fprintf(stdout,"Token: " #token "\tReturned.\n")

  /* define the tokens to be returned. ONLY in DEBUG mode, when in normal
   * operation the tokens are defined by yacc.
   */
  enum tokens { IF_T,
	        SET_T,
	        ICON_T,
	        NAME_T,
	        PATH_T,
	        ASSIGN_T,
	        EQUAL_T,
		NEQUAL_T,
	        STRING_T,
	        SEMIC_T,
	        O_PAR_T,
	        C_PAR_T,
	        O_BRACE_T,
	        C_BRACE_T,
		DEFICON_T,
		CHECKPATH_T,
		TRUE_T,
		FALSE_T,
		TYPE_T,
                DIR_T,
		FILE_T,
		READ_T,
		WRITE_T,
		EXE_T,
		BLOCK_T,
		CHARACTER_T,
		SLINK_T,
		SOCKET_T,
		FIFO_T,
		PROG_T,
		OPTIONS_T,
		TERMOPT_T,
		COMMA_T,
		MSEL_T,
		OSEL_T,
		NSEL_T,
		ASEL_T,
		DEFINE_T,
		DEFAPPL_T,
		TERM_T,
		NOTERM_T,
		FIRST_T,
		COLON_T,
		IGNORE_T,
		ERRORTOKEN
	      };

#else           /* No DEBUG */

#include "parser.h"         /* get the tokens from yacc */

/* define the RETURN token to set the return value to the token to be
 * returned, then return that token.
 */
# define RETURN(token)    yylval.number=token;return(token)
#endif

#include <sys/types.h>
#include <stdio.h>

#define MAXERR      0       /* Maximum number of errors before the parser */
                            /* quits. */

void yyerror(
#if NeedFunctionPrototypes
	     char*
#endif
	     );

typedef struct {                    /* structure for keyword table */
    String name;
    int token;
} keyword;

static keyword keywordtable[] = {   /* table of keywords, in alphabetical order */
  {"ASEL",    ASEL_T},
  {"False",   FALSE_T},
  {"MSEL",    MSEL_T},
  {"NOTERM",  NOTERM_T},
  {"NSEL",    NSEL_T},
  {"OSEL",    OSEL_T},
  {"TERM",    TERM_T},
  {"True",    TRUE_T},
  {"block",   BLOCK_T},
  {"character", CHARACTER_T},
  {"checkpath", CHECKPATH_T},
  {"cmd",     CMD_T},
  {"defappl", DEFAPPL_T},
  {"deficon", DEFICON_T},
  {"define",  DEFINE_T},
  {"dir",     DIR_T},
  {"exe",     EXE_T},
  {"false",   FALSE_T},
  {"fifo",    FIFO_T},
  {"file",    FILE_T},
  {"first",   FIRST_T},
  {"icon",    ICON_T},
  {"if",      IF_T},
  {"ignore",  IGNORE_T},
  {"name",    NAME_T},
  {"options", OPTIONS_T},
  {"path",    PATH_T},
  {"prog",    PROG_T},
  {"read",    READ_T},
  {"set",     SET_T},
  {"slink",   SLINK_T},
  {"socket",  SOCKET_T},
  {"termopt", TERMOPT_T},
  {"true",    TRUE_T},
  {"type",    TYPE_T},
  {"write",   WRITE_T}
};
/* number of entries in the keyword table */
static int numkeywords = (sizeof(keywordtable)/sizeof(keywordtable[0]));

int parseerror=0;                   /* Number of parse errors */
char errormessage[255];             /* used for error messsages */

/*
 * ``yylineno'' not POSIX standard, so have to simulate it when using flex.
 */
#ifdef FLEX_SCANNER
int yylineno=0;
#endif

%}
%%
[\t ]*"#".*     { /* Remove Comments from beginning of line */ }
"="             { RETURN(ASSIGN_T);     }
"=="            { RETURN(EQUAL_T);      }
"{"             { RETURN(O_BRACE_T);    }
"}"             { RETURN(C_BRACE_T);    }
"("             { RETURN(O_PAR_T);      }
")"             { RETURN(C_PAR_T);      }
";"             { RETURN(SEMIC_T);      }
","             { RETURN(COMMA_T);      }
":"		{ RETURN(COLON_T);	}
[A-Za-z]+       { int token = parse_keyword(yytext);
#ifndef DEBUG_LEX
		  yylval.number = token;
                  return(token);
#endif
		}

\n		{
#ifdef FLEX_SCANNER
  		  yylineno++; 
#endif
		}
[\t ]           { /* Ignore White space */ }
\"[^\"]*\"      {
#ifdef DEBUG_LEX
                  fprintf(stdout, "Token STRING_T %s returned", yytext);
#else
		  yylval.string = yytext;
                  return(STRING_T);
#endif
                }
.               { 
		sprintf(errormessage, "illegal character \'%c\'.", yytext[0]);
		yyerror(errormessage);
                }
%%


/*****************************************************************************
 *                                yywrap                                     *
 *****************************************************************************/
int yywrap()
{
    /* function called when EOF encounterd.
     *
     * - Takes nothing
     * + returns EOF token, not actually used other than to indicate an error
     *   to the parser. Useful in DEBUG mode to see that EOF has been detected.
     */

    RETURN(EOFTOKEN);
}


/*****************************************************************************
 *                            parse_keyword                                  *
 *****************************************************************************/
int parse_keyword(str)
String str;
{
  /* Function to determine whether a string is a reserved keyword or an
   * identifier. A table of keywords is searched via a binary search to check
   * to see if the string is a keyword,if it is found the associated
   * token is returned, otherwise an error is printed and ERRORTOKEN
   * is returned.
   * The effect of debugging is to prevent the assignment
   * to the yacc structure, and to print out the keyword if found.
   *
   * - Takes a string to check
   * + Returns a token (int)
   */
  
  register int lower = 0, upper = numkeywords-1;
  
  while (lower <= upper) {
    int middle = (lower + upper) /2;
    keyword *p = &keywordtable[middle];
    int res = strcmp(p->name, str);
    
    if (res < 0) {
      lower = middle +1;
    } else if (res == 0) {
#ifdef DEBUG_LEX
      fprintf(stdout, "Token: %s\tReturned.\n", p->name);
#endif
      return(p->token);
    } else {
      upper = middle -1;
    }
  }
  sprintf(errormessage, "unknown keyword \'%s\'.", yytext);
  yyerror(errormessage);
  RETURN(ERRORTOKEN);
}

/****************************************************************************
 *                                     yyerror                              *
 ****************************************************************************/
void yyerror(message)
char *message;
{
  /* For the moment (29/3/92) the program will be terminated on the first
   * parse error, this is due to the complexities involved in continuing
   * the parse after an error.
   * Edward Groenendaal.
   *
   */
  
  extern int yylineno;
  
  if (preferences_filename == NULL) 
    preferences_filename = XtNewString("config file");

  if (parseerror < MAXERR) {
    fprintf(stderr, "(E) %s:line :%2d: ", preferences_filename, yylineno);
    fprintf(stderr, "%s\n", message);
    parseerror++;
  } else {
    fprintf(stderr, "(E) %s:line :%2d: ", preferences_filename, yylineno);
    fprintf(stderr, "%s\n", message);
    parseerror++;
    /* fprintf(stderr, "Fatal error: over %d errors, exiting\n", MAXERR); */
    exit(2);
  }
}
