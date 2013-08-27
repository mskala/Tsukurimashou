all: \
  rmreleases \
  ul/.htaccess \
  ul/index.php.en ul/index.php.ja \
  ul/beikaitoru.php.en ul/beikaitoru.php.ja \
  ul/genjimon.php.en ul/genjimon.php.ja \
  ul/idsgrep.php.en ul/idsgrep.php.ja \
  ul/kleknev.php.en ul/kleknev.php.ja \
  ul/ocr.php.en ul/ocr.php.ja \
  ul/prosimii-print.css ul/prosimii-screen.css \
  ul/demo200.png ul/flag-jp.png ul/flag-en.png ul/rss.png \
  ul/rg00.png ul/rglyph.php \
  ul/dlicon.png

ul/.htaccess: dot-htaccess
	mkdir -p ul
	cp dot-htaccess ul/.htaccess

ul/rglyph.php: ul/.htaccess rglyph.php
	cp rglyph.php ul/rglyph.php

rmreleases:
	rm -f releases.rss release-dump.txt

.PHONY: rmreleases

releases.rss:
	lynx -source \
	  'http://sourceforge.jp/projects/tsukurimashou/releases/rss' \
	  > releases.rss

release-dump.txt:
	lynx -dump \
	  'http://sourceforge.jp/projects/tsukurimashou/releases/' \
	  > release-dump.txt
	lynx -dump \
	  'http://sourceforge.jp/projects/tsukurimashou/releases/?package_id=13300' \
	  >> release-dump.txt

ul/%.php.en: ul/.htaccess mkindex ../doc/kanjichart.tex \
  releases.rss release-dump.txt default.dat %.dat
	perl -CDS ./mkindex en default.dat $*.dat > $@

ul/%.php.ja: ul/.htaccess mkindex ../doc/kanjichart.tex \
  releases.rss release-dump.txt default.dat %.dat
	perl -CDS ./mkindex ja default.dat $*.dat > $@

ul/%.png: %.png ul/.htaccess
	cp $< $@

ul/%.css: %.css ul/.htaccess
	cp $< $@

ul/prosimii-print.css: prosimii-print.css

ul/prosimii-screen.css: prosimii-screen.css

ul/demo200.png: demo200.png

ul/flag-jp.png: flag-jp.png

ul/flag-en.png: flag-en.png

ul/rss.png: rss.png

ul/rglyph.php: rglyph.php

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
