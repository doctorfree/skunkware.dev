#!/bin/sh
# From: James Cribb jamesc@zip.com.au
# URL:  http://www.zip.com.au/~jamesc/tblfmt
#----------------------------------------------------------------------
# Align input into columns.
#
# Requires scanning the input twice --
# the first pass works out column widths and guesses left/right
# justification (only numeric columns are right-justified).
#
# As well as the usual awk control over FS and such,
# hl is the number of "header lines" (default=1):
# these lines are ignored when determining if a column is numeric.
#
# Example of use:
#
#	tblfmt FS='^I' OFS=' | ' hl=2 file1 file2
#
# treats file1 and file2 as containing data in columns separated by tabs,
# with 2 header lines (file1 lines 1-2), and aligns them with " | "
# between the output columns (default OFS is two blanks).
#----------------------------------------------------------------------

# Temp files.
data=/tmp/tblfmtdata$$
prog=/tmp/tblfmtprog$$
trap "/bin/rm -f $data $prog; exit;" 0 1 2 15

# Work out format.
awk 'BEGIN { hl=1; OFS="  " }
{
    # Copy through, but change to a standard FS.
    printf "%s", $1
    for (i=2;  i<=NF;  i++)
	printf "%s", $i
    printf "\n"

    for (i=1;  i<=NF;  i++)
    {
	# Work out width for each column.
	if (length($i) > colWidth[i])
	    colWidth[i] = length($i)

	# Work out left/right justification if not a header line.
	if (NR > hl  &&  $i != ""  &&  $i != 0 + $i)
	    nonNumeric[i] = 1
    }

    if (NF > maxcol)
	maxcol = NF
}

# Create the format script.
END \
{
    if (maxcol <= 0)
	exit

    for (i=1;  i<maxcol;  i++)
    {
	if (nonNumeric[i])
	    fmt = fmt "%-" colWidth[i] "s" OFS
	else
	    fmt = fmt "%"  colWidth[i] "s" OFS
    }
    if (nonNumeric[maxcol])
	fmt = fmt "%s"
    else
	fmt = fmt "%" colWidth[maxcol] "s"

    printf "{printf \"%s\\n\"", fmt >prog
    for (i=1;  i<=maxcol;  i++)
	printf ", $%d", i >prog
    printf "}\n", i >prog
}
' prog=$prog "$@" >$data

# Run the format script on the data.
[ -s $prog ] && awk -F'' -f $prog $data

#EOF
