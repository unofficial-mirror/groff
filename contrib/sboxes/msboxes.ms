.nr LL 17c
.nr LT \n[LL]
.nr PO 2c
.nr PS 11
.nr VS 13
.nr PI 3.5n
.nr HM 2c
.nr FM 2c
.nr QI 7n
.\" .nr PD 7p
.ll 17c
.po 2c
.\" .RP no
.ND March 2021
.EH '%''March 2021'
.EF ''''
.OH 'Using PDF boxes with the \f[I]ms\f[] macros''%'
.OF ''''
.TL
Using PDF boxes with the \f[I]ms\f[] macros
.AU
Deri James
.AI
deri@chuzzlewit.myzen.co.uk
.\" .AB no
.ds FAM H
.LP
A recent extension to the Groff PDF driver allows coloured rectangles to be
created beneath any output created by groff. The extension is a new "\eX'pdf:'"
command (with a convenience command
.B pdfbackground
with the same parameters):-
.QS
.BoxStart SHADED cornsilk OUTLINED brown INDENT 2n WEIGHT 1p
\M[floralwhite]\c
.pdfbackground pagefill
\M[]\c
.B
\eX'pdf: background
.BI
cmd left top right bottom weight'
.br
.B .pdfbackground
.BI
cmd left top right bottom weight'
.LP
Where:-
.IP cmd 7n
Can be any of "page|fill|box" in combination. So "pagefill" would draw a
rectangle which covers whole current page size (in which case the rest of the
parameters can be omitted because the box dimensions are taken from the
current media size). "boxfill", on the other hand, requires the given
dimensions to place the box. Including "fill" in the command will make the
rectangle filled with the current background colour "\eM[colour]" and including
"box" will give the rectangle a border in the current stroke colour
"\em[colour]".
.sp \n[PD]u
The "cmd" may also be "off", on its own, which will terminate drawing the
current box. If you have specified a page colour
with
.B ".pdfbackground pagefill
it is always the first box in the stack, and if
you specify it again it will replace the first entry. Be aware that the
pagefill box renders the page opaque so tools which "watermark" pdf pages are
unlikely to be successful. To return the background to transparent do a
.B ".pdfbackground off
with no other boxes open
.sp \n[PD]u
Finally the command may be "footnote" followed by a new value for "bottom"
which will be used for all current boxes, just for the current page. This is
to allow room for footnotes which grow during the page.\m[red]\**\m[]
.FS
If the value is negative it is used as an offset from the bottom of the page.
.FE
.LP
.IP left
.IP top
.IP right
.IP bottom 7n
Are the coordinates of the box. The "top" and "bottom" coordinates are
the minimum and maximum for the box, since the actual start of the
box is the vertical position of groff when you issue the command and the bottom of
the box is the point where you turn the box "off". The top and bottom
coordinates are only used if the box drawing extends onto the next page, so,
ordinarily they would be set to the header and footer margins.
.IP weight 7n
If "box" is included in the command then this parameter provides the line width
for the box border.
.BoxStop
.QE
More convenience can be gained by including -msboxes on the groff command line
which includes the macros "BoxStart" and "BoxStop".
.QS
.BoxStart SHADED cornsilk OUTLINED brown INDENT 2n WEIGHT 1p
.BoxStart SHADED cornsilk3 INDENT 2p
.B .BoxStart
.R SHADED
.I colour
.R OUTLINED
.I colour
.R INDENT
.I size
.R WEIGHT
.I size
.BoxStop
.LP
Where SHADED gives the fill colour and OUTLINED the border colour. Omit either
to get a borderless filled box, or just a border with no fill. WEIGHT is used
if the box is OUTLINED.
.LP
INDENT is a value which leaves a gap between the border and the contents inside
the box.
.BoxStop
.QE
Boxes can stacked, so you can start a box within another box, usually the
later boxes would be smaller than the containing box, but this is not
enforced. If using the BoxStart macro the left position is the current indent
minus the INDENT in the command, and the right position is the left position
(calculated above) plus the current line length and twice the indent.
The macro definition of .BoxStart above has been given a box without borders
and a 2p indent.
.QS
.BoxStart SHADED cornsilk OUTLINED brown INDENT 2n WEIGHT 1p
.BoxStart SHADED cornsilk3 INDENT 2p
.B .BoxStop
.BoxStop
.LP
There are no parameters, it closes the last box at the current vertical
position, after adding the Indent spacing.
.BoxStop
.QE
This macro package has one further feature, it attempts to hook into the ms
package to receive notifications when footnotes are growing, so that it can
close boxes before the footnotes are printed. If there are footnotes on a page
it will close current boxes 2p above the footnote separator, this probably
will not match the indent amount requested.
.LP
The above was produced by the following code.
.ds FAM C
.nr PS 9
.nr VS 10
.nf
.LP
.BoxStart SHADED white OUTLINED brown INDENT 2n WEIGHT 1p
.nf
\&.nr LL 17c
\&.nr LT \en[LL]
\&.nr PO 2c
\&.nr PS 11
\&.nr VS 13
\&.nr PI 3.5n
\&.nr HM 2c
\&.nr FM 2c
\&.nr QI 7n
\&.\" .nr PD 7p
\&.ll 17c
\&.po 2c
\&.\" .RP no
\&.ND March 2021
\&.EH '%''March 2021'
\&.EF ''''
\&.OH 'Using PDF boxes with the \ef[I]ms\ef[] macros''%'
\&.OF ''''
\&.TL
Using PDF boxes with the \ef[I]ms\ef[] macros
\&.AU
Deri James
\&.AI
deri@chuzzlewit.myzen.co.uk
\&.\" .AB no
\&.ds FAM H
\&.LP
A recent extension to the Groff PDF driver allows coloured rectangles to be
created beneath any output created by groff. The extension is a new "\eX'pdf:'"
command (with a convenience command
\&.B pdfbackground
with the same parameters):-
\&.QS
\&.BoxStart SHADED cornsilk OUTLINED brown INDENT 2n WEIGHT 1p
\eM[floralwhite]\ec
\&.pdfbackground pagefill
\eM[]\ec
\&.B
\eX'pdf: background
\&.BI
cmd left top right bottom weight'
\&.br
\&.B .pdfbackground
\&.BI
cmd left top right bottom weight'
\&.LP
Where:-
\&.IP cmd 7n
Can be any of "page|fill|box" in combination. So "pagefill" would draw a
rectangle which covers whole current page size (in which case the rest of the
parameters can be omitted because the box dimensions are taken from the
current media size). "boxfill", on the other hand, requires the given
dimensions to place the box. Including "fill" in the command will make the
rectangle filled with the current background colour "\eM[colour]" and including
"box" will give the rectangle a border in the current stroke colour
"\em[colour]".
\&.sp \n[PD]u
The "cmd" may also be "off", on its own, which will terminate drawing the
current box. If you have specified a page colour
with
\&.B ".pdfbackground pagefill
it is always the first box in the stack, and if
you specify it again it will replace the first entry. Be aware that the
pagefill box renders the page opaque so tools which "watermark" pdf pages are
unlikely to be successful. To return the background to transparent do a
\&.B ".pdfbackground off
with no other boxes open
\&.sp \n[PD]u
Finally the command may be "footnote" followed by a new value for "bottom"
which will be used for all current boxes, just for the current page. This is
to allow room for footnotes which grow during the page.\m[red]\e**\**\m[]
.FS
This is just a long footnote. Its purpose is only to check that the bottom of
the box on this page has been adjusted because of the size of the footnote.
.FE
\&.FS
If the value is negative it is used as an offset from the bottom of the page.
\&.FE
\&.LP
\&.IP left
\&.IP top
\&.IP right
\&.IP bottom 7n
Are the coordinates of the box. The "top" and "bottom" coordinates are
the minimum and maximum for the box, since the actual start of the
box is the vertical position of groff when you issue the command and the bottom of
the box is the point where you turn the box "off". The top and bottom
coordinates are only used if the box drawing extends onto the next page, so,
ordinarily they would be set to the header and footer margins.
\&.IP weight 7n
If "box" is included in the command then this parameter provides the line width
for the box border.
\&.BoxStop
\&.QE
More convenience can be gained by including -msboxes on the groff command line
which includes the macros "BoxStart" and "BoxStop".
\&.QS
\&.BoxStart SHADED cornsilk OUTLINED brown INDENT 2n WEIGHT 1p
\&.BoxStart SHADED cornsilk3 INDENT 2p
\&.B .BoxStart
\&.R SHADED
\&.I colour
\&.R OUTLINED
\&.I colour
\&.R INDENT
\&.I size
\&.R WEIGHT
\&.I size
\&.BoxStop
\&.LP
Where SHADED gives the fill colour and OUTLINED the border colour. Omit either
to get a borderless filled box, or just a border with no fill. WEIGHT is used
if the box is OUTLINED.
\&.LP
INDENT is a value which leaves a gap between the border and the contents inside
the box.
\&.BoxStop
\&.QE
Boxes can stacked, so you can start a box within another box, usually the
later boxes would be smaller than the containing box, but this is not
enforced. If using the BoxStart macro the left position is the current indent
minus the INDENT in the command, and the right position is the left position
(calculated above) plus the current line length and twice the indent.
The macro definition of .BoxStart above has been given a box without borders
and a 2p indent.
\&.QS
\&.BoxStart SHADED cornsilk OUTLINED brown INDENT 2n WEIGHT 1p
\&.BoxStart SHADED cornsilk3 INDENT 2p
\&.B .BoxStop
\&.BoxStop
\&.LP
There are no parameters, it closes the last box at the current vertical
position, after adding the Indent spacing.
\&.BoxStop
\&.QE
This macro package has one further feature, it attempts to hook into the ms
package to receive notifications when footnotes are growing, so that it can
close boxes before the footnotes are printed. If there are footnotes on a page
it will close current boxes 2p above the footnote separator, this probably
will not match the indent amount requested.
\&.LP
.BoxStop
