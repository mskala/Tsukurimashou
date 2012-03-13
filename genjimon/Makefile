default: genjimon.pdf \
  GenjimonMedium.ttf GenjimonReverse.ttf GenjimonWhite.ttf GenjimonBlack.ttf

dist:
	zip genjimon.zip LICENSE Makefile \
  genjimon.pdf genjimon.tex *.ttf *.mp makettf.pe

%.pfb: %.mp genjimon.mp
	mkfont1 $*
	rm -f $*.tfm $*.map $*.enc $*.afm $*.pfi

GenjimonMedium.ttf: genjimon-medium.pfb makettf.pe
	fontforge makettf.pe medium Medium

GenjimonReverse.ttf: genjimon-reverse.pfb makettf.pe
	fontforge makettf.pe reverse Reverse

GenjimonWhite.ttf: genjimon-white.pfb makettf.pe
	fontforge makettf.pe white White

GenjimonBlack.ttf: genjimon-black.pfb makettf.pe
	fontforge makettf.pe black Black

genjimon.pdf: genjimon.tex \
  GenjimonMedium.ttf GenjimonReverse.ttf GenjimonWhite.ttf GenjimonBlack.ttf
	xelatex genjimon
