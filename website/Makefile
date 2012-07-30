all: \
  ul/.htaccess \
  ul/index.html.en ul/index.html.jp \
  ul/prosimii-print.css ul/prosimii-screen.css \
  ul/demo200.png ul/flag-jp.png ul/flag-en.png ul/rss.png

ul/.htaccess: dot-htaccess
	mkdir -p ul
	cp dot-htaccess ul/.htaccess

ul/index.html.en ul/index.html.jp: \
  ul/.htaccess mkindex ../doc/kanjichart.tex
	lynx -source \
	  'http://sourceforge.jp/projects/tsukurimashou/releases/rss' \
	  > releases.rss
	lynx -dump \
	  'http://sourceforge.jp/projects/tsukurimashou/releases/' \
	  > release-dump.txt
	perl -CDS ./mkindex

ul/%.png: %.png
	cp $< $@

ul/%.css: %.css
	cp $< $@

upload: all
	scp ul/.htaccess ul/* \
	  mskala@shell.sourceforge.jp:/home/groups/t/ts/tsukurimashou/htdocs/
