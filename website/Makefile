all: \
  ul/.htaccess \
  ul/index.html.en ul/index.html.jp \
  ul/prosimii-print.css ul/prosimii-screen.css \
  ul/demo200.png ul/flag-jp.png ul/flag-en.png ul/rss.png \
  ul/rg00.png ul/rglyph.php

ul/.htaccess: dot-htaccess
	mkdir -p ul
	cp dot-htaccess ul/.htaccess

ul/rglyph.php: ul/.htaccess rglyph.php
	cp rglyph.php ul/rglyph.php

ul/index.html.en ul/index.html.jp: \
  ul/.htaccess mkindex ../doc/kanjichart.tex
	lynx -source \
	  'http://sourceforge.jp/projects/tsukurimashou/releases/rss' \
	  > releases.rss
	lynx -dump \
	  'http://sourceforge.jp/projects/tsukurimashou/releases/' \
	  > release-dump.txt
	perl -CDS ./mkindex

ul/%.png: %.png url/.htaccess
	cp $< $@

ul/%.css: %.css url/.htaccess
	cp $< $@

glyphgrid.pdf: glyphgrid.tex
	xelatex glyphgrid
	xelatex glyphgrid

ul/rg00.png: glyphgrid.pdf
	gs -sDEVICE=ppmraw -q -sOutputFile=- -r600 \
	  glyphgrid.pdf < /dev/null | pnmscale 0.25 | \
	  pamdice -width 150 -height 150 -outstem rg
	rename _0 '' rg*.ppm
	rename _0 '' rg*.ppm
	for foo in rg*.ppm ; do \
	  pnmtopng < $$foo > ul/`basename $$foo .ppm`.png ; done

upload: all
	scp ul/.htaccess ul/* \
	  mskala@shell.sourceforge.jp:/home/groups/t/ts/tsukurimashou/htdocs/
