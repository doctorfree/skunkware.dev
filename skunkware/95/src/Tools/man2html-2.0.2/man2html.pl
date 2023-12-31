#! /usr/local/contrib/bin/perl
##---------------------------------------------------------------------------##
##  File:
##      man2html
##  Author:
##      Earl Hood       ehood@convex.com
##  Description:
##      man2html is a Perl program to convert formatted nroff output
##	to HTML.
##	
##	Recommend command-line options based on platform:
##
##	Platform		Options
##	---------------------------------------------------------------------
##	c2mp			<None, the defaults should be okay>
##	hp9000s700/800		-leftm 1 -topm 8
##	sun4			-sun
##	---------------------------------------------------------------------
##
##---------------------------------------------------------------------------##
##  Copyright (C) 1994  Earl Hood, ehood@convex.com
##
##  This program is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 2 of the License, or
##  (at your option) any later version.
##  
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##  
##  You should have received a copy of the GNU General Public License
##  along with this program; if not, write to the Free Software
##  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
##---------------------------------------------------------------------------##

require 'newgetopt.pl' || die "Unable to require newgetopt.pl\n";

($PROG = $0) =~ s/.*\///;
$VERSION = "2.0.2";

## Backspace character:  Used in overstriking detection
$bs = "\b";

##	Associative array of section titles and their HTML tag wrapper.
##	This list allows customization of what HTML tag is used for
##	a given section head.
##
##	The section title can be a regular expression.  Therefore, one must
##	be careful about quoting special characters.
##
%SectionHead = (

    '\S.*OPTIONS.*', '<H2>',
    'AUTHORS?', '<H2>',
    'BUGS', '<H2>',
    'COMPATIBILITY', '<H2>',
    'DEPENDENCIES', '<H2>',
    'DESCRIPTION', '<H2>',
    'DIAGNOSTICS', '<H2>',
    'ENVIRONMENT', '<H2>',
    'ERRORS', '<H2>',
    'EXAMPLES', '<H2>',
    'EXTERNAL INFLUENCES', '<H2>',
    'FILES', '<H2>',
    'LIMITATIONS', '<H2>',
    'NAME', '<H2>',
    'NOTES?', '<H2>',
    'OPTIONS', '<H2>',
    'REFERENCES', '<H2>',
    'RETURN VALUE', '<H2>',
    'SECTION.*:', '<H2>',
    'SEE ALSO', '<H2>',
    'STANDARDS CONFORMANCE', '<H2>',
    'STYLE CONVENTION', '<H2>',
    'SYNOPSIS', '<H2>',
    'SYNTAX', '<H2>',
    'WARNINGS', '<H2>',
    '\s+Section.*:', '<H3>',

);
$HeadFallback = '<H2>';  # Fallback tag if above is not found.

##---------------------------------------------------------------------------
##-----------##
## MAIN Body ##
##-----------##
{
&get_cli_opts();

## Check if processing a keyord search
if ($K && $CGIURL) { &man_k(); exit 0; }

local($line,$tmp,$i,$head,$preindent,$see_also);
$see_also = 1;

if (!$BARE) {
    print STDOUT "<HTML>\n";
    print STDOUT "<HEAD>\n",
		 "<TITLE>$TITLE</TITLE>\n",
		 "</HEAD>\n"  if $TITLE;
    print STDOUT "<BODY>\n";
    print STDOUT "<H1>$TITLE</H1>\n",
		 "<HR>\n"  if $TITLE;
}
print STDOUT "<PRE>\n";
while(!eof(STDIN)) {
    for ($i=0; $i < $hdsz; $i++) { <STDIN>; }
    for ($i=0; $i < $txsz; $i++) {
	$_ = <STDIN>;

	## Try to check if line space is needed at page boundaries ##
	if (!$NODEPAGE && ($i==0 || $i==($txsz-1)) && !/^\s*$/) {
	    /^(\s*)/;  $tmp = length($1);
	    if ($do) {
		if ($tmp < $preindent) { print STDOUT "\n"; }
	    } else {
		$do = 1;
	    }
	    $preindent = $tmp;
	} else {
	    $do = 0;  $preindent = 0;
	}

	## Interpret line
	$line = $_;
	&entitize(*_);		# Convert [$<>] to entity references

	## Create anchor links for manpage references
    s/((((.$bs)+)?[\+_\.\w-])+\(((.$bs)+)?\d((.$bs)+)?\w?\))/&make_xref($1)/oge
	    if $CGIURL && $see_also;

	## Emphasize underlined words
	s/((_\010[^_])+[\.\(\)_]?(_\010[^_])+\)?)/&emphasize($1)/oge;
	$secth = 0;
	## Check for strong text and headings
	if ($SUN || /.\010./o) {
	    if (!$NOHEADS) {
		$line =~ s/.\010//go;
		$tmp = $HeadFallback;
		foreach $head (keys %SectionHead) {
		    if ($line =~ /^$leftm$head/) {
			$tmp = $SectionHead{$head};
			$secth = 1;
			last;
		    }
		}
		if ($secth || $line =~ /^$leftm\S/o) {
		    if ($CGIURL && $SEEALSO) {
			if ($line =~ /SEE ALSO/o) { $see_also = 1; }
			else { $see_also = 0; }
		    }
		    chop $line;
		    $_ = $tmp . $line . $tmp;
		    s%<([^>]*)>$%</$1>%;
		    $_ = "\n</PRE>\n" . $_ . "<PRE>\n";
		} else {
		    s/(((.\010)+.)+)/&strongize($1)/oge;
		}
	    } else {
		s/(((.\010)+.)+)/&strongize($1)/oge;
	    }
	}
	print STDOUT;
    }
    for ($i=0; $i < $ftsz; $i++) { <STDIN>; }
}
print STDOUT "</PRE>\n",
	     "</BODY>\n",
	     "</HTML>\n"  unless $BARE;
exit 0;
}  ## End Main
##---------------------------------------------------------------------------
sub get_cli_opts {
    &usage unless
    &NGetOpt(
	"botm=i",	# Number of lines for bottom margin (def: 7)
	"headmap=s",	# Filename of user section head map file
	"leftm=i",	# Character width of left margin (def: 0)
	"nodepage",	# Do not remove pagination lines
	"noheads",	# Do not detect for section heads
	"pgsize=i",	# Number of lines in a page (def: 66)
	"title=s",	# Title of manpage (def: Not defined)
	"topm=i",	# Number of lines for top margin (def: 7)
	"sun",		# Section heads are not overstriked in input
	"cgiurl=s",	# CGI URL for linking to other manpages
	"seealso",	# Link to other manpages only in the SEE ALSO section
	"k",		# Process input from 'man -k' output.
	"bare",		# Leave out HTML, HEAD, BODY tags.
	"help"		# Short usage message
    );
    &usage() if defined($opt_help);

    $pgsz = ($opt_pgsize ? $opt_pgsize : 66);
    if (defined($opt_nodepage)) {
	$hdsz = 0;
	$ftsz = 0;
    } else {
	$hdsz = (defined($opt_topm) ? $opt_topm : 7);
	$ftsz = (defined($opt_botm) ? $opt_botm : 7);
    }
    $txsz    = $pgsz - ($hdsz + $ftsz);
    $leftmsz = (defined($opt_leftm) ? $opt_leftm : 0);
    $leftm   = ' ' x $leftmsz;

    $TITLE   = ($opt_title ? $opt_title : "");
    $NOHEADS = (defined($opt_noheads) ? 1 : 0);
    $SUN     = (defined($opt_sun) ? 1 : 0);
    $CGIURL  = ($opt_cgiurl ? $opt_cgiurl : "");
    $SEEALSO = ($opt_seealso ? 1 : 0);
    $K       = ($opt_k ? 1 : 0);
    $BARE    = ($opt_bare ? 1 : 0);

    if (defined($opt_headmap)) {
	require $opt_headmap || warn "Unable to read $opt_headmap\n";
    }
}
##---------------------------------------------------------------------------
sub emphasize {
    local($txt) = shift;
    $txt =~ s/.\010//go;
    $txt = "<EM>$txt</EM>";
    $txt;
}
##---------------------------------------------------------------------------
sub strongize {
    local($txt) = shift;
    $txt =~ s/.\010//go;
    $txt = "<STRONG>$txt</STRONG>";
    $txt;
}
##---------------------------------------------------------------------------
sub entitize {
    local(*txt) = shift;

    ## Check for special characters in overstrike text ##
    $txt =~ s/_\010\&/&strike('_', '&')/geo;
    $txt =~ s/_\010</&strike('_', '<')/geo;
    $txt =~ s/_\010>/&strike('_', '>')/geo;

    $txt =~ s/(\&\010)+\&/&strike('&', '&')/geo;
    $txt =~ s/(<\010)+</&strike('<', '<')/geo;
    $txt =~ s/(>\010)+>/&strike('>', '>')/geo;

    ## Check for special characters in regular text.  Must be careful
    ## to check before/after character in expression because it might be
    ## a special character.
    $txt =~ s/([^\010]\&[^\010])/&htmlize2($1)/geo;
    $txt =~ s/([^\010]<[^\010])/&htmlize2($1)/geo;
    $txt =~ s/([^\010]>[^\010])/&htmlize2($1)/geo;
}
##---------------------------------------------------------------------------
##	htmlize2() is used by entitize.
##
sub htmlize2 {
    local($str) = shift;
    $str =~ s/&/\&amp;/g;
    $str =~ s/</\&lt;/g;
    $str =~ s/>/\&gt;/g;
    $str;
}
##---------------------------------------------------------------------------
##	strike converts HTML special characters in overstriked text
##	into entity references.  The entities are overstriked so
##	strongize() and emphasize() will recognize the entity to be
##	wrapped in <STRONG>/<EM> tags.
##
sub strike {
    local($w, $char) = @_;
    local($ret);
    if ($w eq '_') {
	if ($char eq '&') {
	    $ret = "_$bs\&_${bs}a_${bs}m_${bs}p_${bs};";
	} elsif ($char eq '<') {
	    $ret = "_$bs\&_${bs}l_${bs}t_${bs};";
	} elsif ($char eq '>') {
	    $ret = "_$bs\&_${bs}g_${bs}t_${bs};";
	} else {
	    warn qq|Unrecognized character, "$char", passed to strike()\n|;
	}
    } else {
	if ($char eq '&') {
	    $ret = "\&$bs\&a${bs}am${bs}mp${bs}p;${bs};";
	} elsif ($char eq '<') {
	    $ret = "\&$bs\&l${bs}lt${bs}t;${bs};";
	} elsif ($char eq '>') {
	    $ret = "\&$bs\&g${bs}gt${bs}t;${bs};";
	} else {
	    warn qq|Unrecognized character, "$char", passed to strike()\n|;
	}
    }
    $ret;
}
##---------------------------------------------------------------------------
##	make_xref() was originally added to man2html by Maurice Cinquini
##	<mauricec@tplrd.tpl.oz.au> for use in the SEE ALSO section.  The
##	code has been modified to handle more general cases, and the routine
##	is called for all manpage cross-references throughout.
##
##	Specifically, I modified it to support the user's URL template for
##	linking to other manpages, support for [+_,-] in the title name,
##	and to handle <EM> tagging.
##
sub make_xref {
    local($str) = shift;
    $str =~ s/.\010//go;			# Remove overstriking
    local($title,$section,$subsection) =
	($str =~ /([\+_\.\w-]+)\((\d)(\w?)\)/);

    local($href) = (eval "\"$CGIURL\"");
    qq|<STRONG><A HREF="$href">$str</A></STRONG>|;
}
##---------------------------------------------------------------------------
##	man_k() process a keyword search.
##
sub man_k {
    local($line,$refs,$section,$subsection,$desc,$i,
	  %Sec1, %Sec1sub, %Sec2, %Sec2sub, %Sec3, %Sec3sub,
	  %Sec4, %Sec4sub, %Sec5, %Sec5sub, %Sec6, %Sec6sub,
	  %Sec7, %Sec7sub, %Sec8, %Sec8sub, %Sec9, %Sec9sub,
	  %SecN, %SecNsub, %SecNsec);

    print STDOUT "<HTML>\n";
    print STDOUT "<HEAD>\n",
		 "<TITLE>$TITLE</TITLE>\n",
		 "</HEAD>\n"  if $TITLE;
    print STDOUT "<BODY>\n";
    print STDOUT "<H1>$TITLE</H1>\n",
		 "<HR>\n"  if $TITLE;
    while ($line = <STDIN>) {
	next if $line !~ /\(\d\w?\)\s*-/;
	($refs,$section,$subsection,$desc) =
	    $line =~ /^\s*(.*)\((\d)(\w?)\)\s*-\s*(.*)$/;
	$refs =~ s/\s(and|or)\s/,/gi;	# Convert and/or to commas
	$refs =~ s/\s//g;		# Remove all whitespace
	$refs =~ s/,/, /g;		# Put space after comma
	&htmlize(*desc);		# Check for special chars in desc
	$desc =~ s/^(.)/\U$1/;		# Uppercase first letter in desc

	if ($section eq '1') {
	    $Sec1{$refs} = $desc; $Sec1sub{$refs} = $subsection;
	} elsif ($section eq '2') {
	    $Sec2{$refs} = $desc; $Sec2sub{$refs} = $subsection;
	} elsif ($section eq '3') {
	    $Sec3{$refs} = $desc; $Sec3sub{$refs} = $subsection;
	} elsif ($section eq '4') {
	    $Sec4{$refs} = $desc; $Sec4sub{$refs} = $subsection;
	} elsif ($section eq '5') {
	    $Sec5{$refs} = $desc; $Sec5sub{$refs} = $subsection;
	} elsif ($section eq '6') {
	    $Sec6{$refs} = $desc; $Sec6sub{$refs} = $subsection;
	} elsif ($section eq '7') {
	    $Sec7{$refs} = $desc; $Sec7sub{$refs} = $subsection;
	} elsif ($section eq '8') {
	    $Sec8{$refs} = $desc; $Sec8sub{$refs} = $subsection;
	} elsif ($section eq '9') {
	    $Sec9{$refs} = $desc; $Sec9sub{$refs} = $subsection;
	} else {			# Catch all
	    $SecN{$refs} = $desc; $SecNsec{$refs} = $section;
	    $SecNsub{$refs} = $subsection;
	}
    }
    &print_mank_sec(*Sec1, 1, *Sec1sub);
    &print_mank_sec(*Sec2, 2, *Sec2sub);
    &print_mank_sec(*Sec3, 3, *Sec3sub);
    &print_mank_sec(*Sec4, 4, *Sec4sub);
    &print_mank_sec(*Sec5, 5, *Sec5sub);
    &print_mank_sec(*Sec6, 6, *Sec6sub);
    &print_mank_sec(*Sec7, 7, *Sec7sub);
    &print_mank_sec(*Sec8, 8, *Sec8sub);
    &print_mank_sec(*Sec9, 9, *Sec9sub);
    &print_mank_sec(*SecN, 'N', *SecNsub, *SecNsec);

    print STDOUT "</DL>\n",
		 "</BODY>\n",
		 "</HTML>\n";
}
##---------------------------------------------------------------------------
##	print_mank_sec() prints out manpage cross-refs of a specific section.
sub print_mank_sec {
    local(*sec, $sect, *secsub, *secsec) = @_;
    local(@array, @refs, $href, $item, $title, $subsection, $i, $section);
    $section = $sect;

    @array = sort keys %sec;
    if ($#array >= 0) {
	print STDOUT "<H2>Section $section</H2>\n",
		     "<DL>\n";
	foreach $item (@array) {
	    $section = $secsec{$item}  if $sect eq 'N';
	    @refs = split(/,/,$item);
	    $title = $refs[0];
	    $title  =~ s/\(\)//g;		# Watch out for extra ()'s
	    $subsection = $secsub{$item};
	    $href = eval "\"$CGIURL\"";		# Create HREF string
	    print STDOUT "<DT>\n";
	    $i = 0;
	    foreach (@refs) {
		print STDOUT qq|<A HREF="$href">$_</A>|;
		print STDOUT ", "  if $i < $#refs;
		$i++;
	    }
	    print STDOUT " ($section$subsection)\n",
			 "<DD>\n",
			 $sec{$item}, "\n";
	}
	print STDOUT "</DL>\n";
    }
}
##---------------------------------------------------------------------------
sub htmlize {
    local(*str) = shift;
    $str =~ s/&/\&amp;/g;
    $str =~ s/</\&lt;/g;
    $str =~ s/>/\&gt;/g;
    $str;
}
##---------------------------------------------------------------------------
sub usage {
    print STDOUT <<EndOfUsage;
Usage: $PROG [ options ] < infile > outfile
Options:
  -bare			: Do not put in HTML, HEAD, BODY tags
  -botm <#>		: Number of lines for bottom margin (def: 7)
  -cgiurl <url>		: URL for linking to other manpages
  -headmap <file>	: Filename of user section head map file
  -help			: This message
  -k			: Process a keyword search result
  -leftm <#>		: Character width of left margin (def: 0)
  -nodepage		: Do not remove pagination lines
  -noheads		: Do not detect for section heads
  -pgsize <#>		: Number of lines in a page (def: 66)
  -seealso		: Link to other manpages only in the SEE ALSO section
  -sun			: Section heads are not overstriked in input
  -title <string>	: Title of manpage (def: Not defined)
  -topm <#>		: Number of line for top margin (def: 7)
Description:
  $PROG takes formatted manpages from STDIN and converts it to HTML sent to
  STDOUT.  The -topm and -botm arguments are the number of lines to the main
  body text and NOT to the running headers/footers.
Version:
  $VERSION

EndOfUsage
    exit 0;
}
