REM() { :; }
REM This little script will print the documentation.  It does this by invoking
REM elvis on each documentation file in turn, telling elvis to print the file
REM via its :lpr command and then quit.  The complete manual should be about
REM 130 pages long.
REM
REM     THIS ASSUMES YOU HAVE ALREADY SET UP THE PRINTING OPTIONS!
REM
REM This script should work under DOS, Windows/NT, and the UNIX "ksh" shell or
REM clones such as "bash".  The first line of this file allows "sh" to accept
REM these REM lines without complaint, by defining it as a do-nothing function.

elvis -gquit -clp elvis.html
elvis -gquit -clp elvisvi.html
elvis -gquit -clp elvisinp.html
elvis -gquit -clp elvisex.html
elvis -gquit -clp elvisre.html
elvis -gquit -clp elvisopt.html
elvis -gquit -clp elvisdm.html
elvis -gquit -clp elvisgui.html
elvis -gquit -clp elvisses.html
elvis -gquit -clp elviscut.html
elvis -gquit -clp elvismsg.html
elvis -gquit -clp elvisexp.html
elvis -gquit -clp elvistip.html
elvis -gquit -clp elvis.man
elvis -gquit -clp ctags.man
elvis -gquit -clp ref.man
elvis -gquit -clp fmt.man
