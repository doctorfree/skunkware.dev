" the leading '"' makes this line a comment
" uncomment lines by removing the leading '"'
"
" tab settings for all XC source files 
set ts=4 sw=4
"
" macros for handling CompuServe downloads
" make sure the ^M, ^K, ^K below are true Ctrl-M, Ctrl-K, Ctrl-X
" make sure the ^[ below are true ESCAPE
"
" set wm=5 nosm ic ai aw
"
" F5 squeezes out empty lines, marks new section with 'm'
" map	#5	/^welcome to.*V\. 3/^M--mm/^Forum !\^H/^Md`mS^[mm^M:.,$g/^ *$/d^M'm
"
" F2 deletes from current line to mark 'm', and leaves a new mark 'm'
" map	#2	d`mS^[mmz^M
"
" with cursor within a message, F1 sets up for a reply
" map	#1	?^#: \([1-9][0-9]*\) .*S[0-9]*/.*?^MY/^M^N
" map	^N	P:s;;re\1;^Mmao/post unf^[mbO
"
" ^X takes a reply prepared after an F1, and appends it to an upload file
"  map	^X	'aO^[:'a,'b w>>%R^M:'a,'b d^[z^M
"
" ^K makes a reply private, then calls ^X
"  map	^K	'bA pri^[^X
"
" F8 places next message at top of screen
" map	#8	/#:/z^M
"
" this old version breaks on int'l vi on the 'put'
" map	#1 ?^#: [1-9][0-9] .*S[1-9][0-9]*/?^MWyt NOre^[pmao/post unf^[mbO
" this depends on the xc script's waitfor construction
" map	#5 /^welcome to /^M--d/^% Choice required$/^MS^[mm^M:.,$g/^ *$/d^M'm
