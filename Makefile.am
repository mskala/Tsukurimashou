## Process this file with automake to produce Makefile.in

# PLEASE NOTE:  The Free Software Foundation's copyright notice, which will
# appear above this note in the generated Makefile.in, applies to the
# portions of the generated Makefile.in that come from automake.
# Matthew Skala's copyright notice, below, applies to the portions that are
# his work.  Distributors of the composite file must comply with both.

#
# Makefile for Tsukurimashou
# Copyright (C) 2011, 2012, 2013  Matthew Skala
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.
#
# As a special exception, if you create a document which uses this font, and
# embed this font or unaltered portions of this font into the document, this
# font does not by itself cause the resulting document to be covered by the
# GNU General Public License. This exception does not however invalidate any
# other reasons why the document might be covered by the GNU General Public
# License. If you modify this font, you may extend this exception to your
# version of the font, but you are not obligated to do so. If you do not
# wish to do so, delete this exception statement from your version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Matthew Skala
# http://ansuz.sooke.bc.ca/
# mskala@ansuz.sooke.bc.ca
#

############################################################################

# BASIC AUTOTOOLS STUFF


ACLOCAL_AMFLAGS = -I m4
@SET_MAKE@
@INC_AMINCLUDE@

mvp:=$(if $(VPATH),$(VPATH),.)

empty:=
space:=$(empty) $(empty)
comma:=,
percent=%

# This is a nasty hack, but seems to be needed to get the variables
# included soon enough for them to be useful in Automake's recipes
ZZZZHACKZZZZ=include makefile-vars.inc
$(error This Makefile must be edited by Perl code in config.status before use)

SHELL=@KLEKNEV@
SUBDIRS = . $(PARASITES)

############################################################################

# SILENT BUILD BLINKENLIGHTS

TSU_V_REDIR=$(if $(AM_V_at),>& /dev/null)

if COND_COLOUR
  ECHO_ANSI=echo -e
  ansi_default=\e[0m
  ansi_red=\e[31m
  ansi_green=\e[32m
  ansi_yellow=\e[33m
  ansi_blue=\e[34m
  ansi_magenta=\e[35m
  ansi_cyan=\e[36m
  ansi_pink=\e[35;1m
  ansi_white=\e[37;1m
  ansi_cleareol=\e[K
  ansi_clearescaped=\033\[K
  ansi_home=\e[1G
  am__@andt@v_CC_0=@echo -e "$(ansi_default)$(ansi_cleareol)  CC    " $@;
  am__@andt@v_CCLD_0=@echo -e "$(ansi_default)$(ansi_cleareol)  CCLD  " $@;
  am__@andt@v_GEN_0=@echo -e "$(ansi_default)$(ansi_cleareol)  GEN   " $@;
else
  ECHO_ANSI=echo
  ansi_default=
  ansi_red=
  ansi_green=
  ansi_yellow=
  ansi_blue=
  ansi_magenta=
  ansi_cyan=
  ansi_pink=
  ansi_white=
  ansi_cleareol=
  ansi_clearescaped=
  ansi_home=
endif

TSU_V_BDF =$(TSU_V_BDF_$(V))
TSU_V_BDF_=$(TSU_V_BDF_$(AM_DEFAULT_VERBOSITY))
TSU_V_BDF_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_yellow)BDF$(ansi_default)   "
TSU_V_BDF_1=@true

TSU_V_HAM=$(TSU_V_HAM_$(V))
TSU_V_HAM_=$(TSU_V_HAM_$(AM_DEFAULT_VERBOSITY))
TSU_V_HAM_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_red)HAM$(ansi_default)   " $@;

TSU_V_KERN=$(TSU_V_KERN_$(V))
TSU_V_KERN_=$(TSU_V_KERN_$(AM_DEFAULT_VERBOSITY))
TSU_V_KERN_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_yellow)KERN$(ansi_default)  "
TSU_V_KERN_1=@true

TSU_V_MAKE=$(TSU_V_MAKE_$(V))
TSU_V_MAKE_=$(TSU_V_MAKE_$(AM_DEFAULT_VERBOSITY))
TSU_V_MAKE_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_white)MAKE$(ansi_default)  " $@;

TSU_V_MT1=$(TSU_V_MT1_$(V))
TSU_V_MT1_=$(TSU_V_MT1_$(AM_DEFAULT_VERBOSITY))
TSU_V_MT1_0=$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_blue)MT1$(ansi_default)   " $@;

TSU_V_NAPERL=$(TSU_V_NAPERL_$(V))
TSU_V_NAPERL_=$(TSU_V_NAPERL_$(AM_DEFAULT_VERBOSITY))
TSU_V_NAPERL_0=$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_magenta)PERL$(ansi_default)  " $@;

TSU_V_NASKIP=$(TSU_V_NASKIP_$(V))
TSU_V_NASKIP_=$(TSU_V_NASKIP_$(AM_DEFAULT_VERBOSITY))
TSU_V_NASKIP_0=$(ECHO_ANSI) -n \
  "$(ansi_cleareol)  SKIP  " $@ "$(ansi_home)";

TSU_V_OTF=$(TSU_V_OTF_$(V))
TSU_V_OTF_=$(TSU_V_OTF_$(AM_DEFAULT_VERBOSITY))
TSU_V_OTF_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_cyan)OTF$(ansi_default)   "
TSU_V_OTF_1=@true

TSU_V_PERL=$(TSU_V_PERL_$(V))
TSU_V_PERL_=$(TSU_V_PERL_$(AM_DEFAULT_VERBOSITY))
TSU_V_PERL_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_magenta)PERL$(ansi_default)  " $@;

TSU_V_RMO=$(TSU_V_RMO_$(V))
TSU_V_RMO_=$(TSU_V_RMO_$(AM_DEFAULT_VERBOSITY))
TSU_V_RMO_0=$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_cyan)RMO$(ansi_default)   " $@;

TSU_V_SFD=$(TSU_V_SFD_$(V))
TSU_V_SFD_=$(TSU_V_SFD_$(AM_DEFAULT_VERBOSITY))
TSU_V_SFD_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_cyan)SFD$(ansi_default)   "
TSU_V_SFD_1=@true

TSU_V_TEX=$(TSU_V_TEX_$(V))
TSU_V_TEX_=$(TSU_V_TEX_$(AM_DEFAULT_VERBOSITY))
TSU_V_TEX_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_green)TEX$(ansi_default)   " $@;

TSU_V_TEXL=$(TSU_V_TEXL_$(V))
TSU_V_TEXL_=$(TSU_V_TEXL_$(AM_DEFAULT_VERBOSITY))
TSU_V_TEXL_0=$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_green)TEX$(ansi_default)   " "$@($$I)";

############################################################################

# CONDITIONAL OPTIONS

KANJIDIC2=@with_kanjidic2@
if COND_BOOKPROOFS
  MAYBE_BOOKPROOFS=$(foreach \
    rn,I II III IV V VI VII VIII IX X XI XII XIII XIV, \
    doc/book$(rn).pdf doc/cover$(rn).pdf)
  PROOF_ND_PASS=4
else
  PROOF_ND_PASS=3
if COND_PROOFS
  MAYBE_PROOFS=doc/proofs.pdf
endif
endif
if COND_DOCS
  MAYBE_DOCS=doc/demo.pdf doc/usermanual.pdf
  MAYBE_MDOCS=$(foreach doc,$(MAINTAINER_DOCS),doc/$(doc).pdf)
endif
if COND_EXPECT
  expect_start= $(if $(AM_V_at),$(EXPECT) -c \
    'log_user 0 ; spawn -noecho sh -c ")
  expect_end= $(if $(AM_V_at), " ; \
    expect -timeout -1 \
    -re "\n! " {exit 1} \
    -re "PROGRESS:(\[^\n\]*)\n" \
      {puts -nonewline \
         "$(ansi_clearescaped)$$expect_out(1,string)\r"; \
       flush stdout;exp_continue} \
    eof ; wait' )
else
  expect_end=$(TSU_V_REDIR)
endif
if COND_KANJIDIC2
  MAYBE_KDDATA=hamlog/kddata.hl
endif
if COND_KANJI_CHART
  MAYBE_KANJI_CHART=doc/kanjichart.pdf
endif

############################################################################

# FILENAMES FOR AUTOTOOLS

EXTRA_DIST:=COPYING.GPL3 \
  README.en README.jp \
  doc/demo.tex doc/proofs.tex doc/usermanual.tex doc/bkstyle.tex \
  $(wildcard $(mvp)/fsc/*.fsc) \
  t1asm/README t1asm/t1asm.1 \
  $(filter-out \
    $(wildcard $(mvp)/mp/jieub-a[c-f].mp) \
    $(wildcard $(mvp)/mp/jieub-[b-d][0-9a-f].mp),\
    $(wildcard $(mvp)/mp/*.mp)) \
  t1asm/README t1asm/t1asm.1

noinst_PROGRAMS = kerner/kerner t1asm/t1asm

kerner_kerner_SOURCES = kerner/kerner.c
t1asm_t1asm_SOURCES = \
  t1asm/t1asm.c t1asm/clp.c t1asm/clp.h t1asm/t1lib.c t1asm/t1lib.h

dist_noinst_SCRIPTS = \
  hamlog/hamlog \
  hamlog/select.hl hamlog/swi-ham.pl hamlog/ecl-ham.ecl hamlog/gp-ham.pl \
  pe/bdf.pe pe/fontlint.pe pe/getbearings.pe pe/kern-font.pe \
  pe/makepngs.pe pe/rmo.pe \
  tools/add-flog tools/autodep tools/livecode \
  tools/make-ass tools/make-book tools/make-cfghl tools/make-cover \
  tools/make-eids tools/make-fea tools/make-flog tools/make-gpos \
  tools/make-hglpages tools/make-kchart tools/make-kddata tools/make-name \
  tools/make-proof \
  tools/mp2pf tools/mpdep tools/progress \
  txt/jnames.txt

dist_otf_DATA = \
  otf/TsukurimashouKaku.otf otf/TsukurimashouMincho.otf \
  otf/TsukurimashouKakuPS.otf otf/TsukurimashouMinchoPS.otf
otf_DATA = $(filter-out $(dist_otf_DATA),\
  $(foreach st,$(SHORT_STYLES), \
    otf/$(subst -,,$(subst $(space),,$(XLAT_$(st)))).otf))
dist_pdf_DATA = $(MAYBE_DOCS) $(MAYBE_KANJI_CHART)
nodist_pdf_DATA = $(MAYBE_MDOCS) $(MAYBE_PROOFS) $(MAYBE_BOOKPROOFS)

############################################################################

# MAKE CLEAN

MOSTLYCLEANFILES = \
  *~ doc/*~ fea/*~ kerner/*~ m4/*~ mp/*~ pe/*~ t1asm/*~ \
  *.prog \
  bdf/*.bdf \
  doc/*.aux doc/*.log doc/*.out doc/*-draft.tex doc/*.toc doc/*.xdv \
  doc/kanjichart.tex \
  doc/pgflibraryshapes.callouts.code.tex \
  fea/*.fea \
  hamlog/kddata.hl hamlog/jnames.hl \
  mp/jieub-a[c-f].mp mp/jieub-[b-d][0-9a-f].mp mp/.hglstamp \
  pe/assemble-font.pe pe/make-empty.pe pe/*-bearing.pe \
  pfb/*.afm pfb/*.pfb \
  pfbtmp/*.pfb prf/*.prf sfd/*.sfd sum/*.sum \
  tsukurimashou.nam \
  txt/fontlog.txt txt/tsukurimashou.eids

CLEANFILES = \
  otf/Tsukurimashou*.otf otf/BlackletterLolita*.otf otf/Jieubsida*.otf \
  doc/*.pdf

DISTCLEANFILES = \
  makefile-pdf.inc makefile-pfb*.inc makefile-vars.inc \
  chl-stamp pfb-stamp* \
  _stdint.h \
  aminclude.am chars.lst hamlog/config.hl doc/version.tex \
  */.dirstamp

############################################################################

# KILL EMPTY FILES

kill_empty=@$(PERL) \
  -e 'while (<$(1)>) { if (-f && -z _) {' \
  -e 'print "DELETING EMPTY FILE $$_\n"; `rm $$_`; } }'

kill-empty:
	$(call kill_empty,pfb/*.pfb)
	$(call kill_empty,sfd/*.sfd)
	$(call kill_empty,otf/*.otf)

.PHONY: kill-empty

############################################################################

# HAMLOG

DEFAULT_TOK = tsuku

PFBSTAMP:=$(strip $(shell $(GREP) 'AUTODEPS\|input\|BEGINFEATURE' \
  $(mvp)/mp/*.mp ./mp/*.mp $(mvp)/fsc/*.fsc | \
  cat - config.log | $(CHECKSUM)))

if COND_PROLOG_ECLIPSE
  HAMLOG=$(PROLOG) -b $(mvp)/hamlog/ecl-ham.ecl -e ecl_run_hamlog_program --
  HAMLOG_AFTER=
  HAMLOG_DEPS=hamlog/ecl-ham.ecl
endif
if COND_PROLOG_GNU
  HAMLOG=$(PROLOG) --init-goal \
    "['$(mvp)/hamlog/gp-ham.pl'],gp_run_hamlog_program" --
  HAMLOG_AFTER= | $(PERL) -ne 'print if $$f; $$f=1 if /OUTPUT/'
  HAMLOG_DEPS=hamlog/gp-ham.pl
endif
if COND_PROLOG_HAMLOG
  HAMLOG=$(PERL) $(mvp)/hamlog/hamlog
  HAMLOG_AFTER=
  HAMLOG_DEPS=hamlog/hamlog
endif
if COND_PROLOG_SWI
  HAMLOG=$(PROLOG) -f $(mvp)/hamlog/swi-ham.pl -t halt --
  HAMLOG_AFTER=
  HAMLOG_DEPS=hamlog/swi-ham.pl
endif

MAYBE_CHL_TICKLER:=\
  $(if $(filter-out x$(PFBSTAMP),x$(shell cat chl-stamp)),chl-tickler)

chl-tickler:

.PHONY: chl-tickler

hamlog/config.hl: tools/make-cfghl \
  config.status $(wildcard $(mvp)/fsc/*.fsc) \
  hamlog/.dirstamp mp/.dirstamp mp/.hglstamp \
  $(sort $(wildcard $(mvp)/mp/*.mp) $(wildcard ./mp/*.mp)) \
  $(MAYBE_CHL_TICKLER)
	$(AM_V_at)if ( test "x$(PFBSTAMP)" = "x`cat chl-stamp`" ) \
	  && ( test -s hamlog/config.hl ) ; then \
	  $(TSU_V_NASKIP) \
	  true ; \
	else \
	  $(TSU_V_NAPERL) \
	  echo '% GENERATED FILE, edit Makefile.am instead' \
	    > hamlog/config.hl ; \
	  $(PERL) -CSD $(mvp)/tools/make-cfghl char '@enable_chars@' \
	    >> hamlog/config.hl ; \
	  $(PERL) -CSD $(mvp)/tools/make-cfghl style '@enable_styles@' \
	    >> hamlog/config.hl ; \
	  $(PERL) -CSD $(mvp)/tools/make-cfghl feature \
	    '@enable_ot_features@' >> hamlog/config.hl ; \
	  $(PERL) -CSD $(mvp)/tools/make-cfghl parasite \
	    '@enable_parasites@' >> hamlog/config.hl ; \
	  if test "x$(enable_proportional)" = "xyes" ; then \
	    echo proportional_enabled. >> hamlog/config.hl ; \
	  else \
	    echo proportional_enabled:-fail. >> hamlog/config.hl ; \
	  fi ; \
	  echo 'generic_family($(DEFAULT_TOK)).' >> hamlog/config.hl ; \
	  ( for a in a b c d; \
	    do for b in 0 1 2 3 4 5 6 7 8 9 a b c d e f ; do \
	      echo jieub-$$a$$b.mp ; done ; done ; \
	    ls $(mvp)/mp/ mp/ ) | \
	  $(PERL) -CSD -n \
	    -e 'print "page_exists($$1,page$$2).\n"' \
	    -e 'if /^([a-z]{3,7})-([0-9a-f]{2,3})\.mp$$/' \
	    | sort | uniq >> hamlog/config.hl ; \
	  $(PERL) -CSD -ne \
	    'print "feature_exists($$1).\n" if /BEGINFEATURE ([a-z0-9_]+)/' \
	    $(mvp)/fsc/*.fsc >> hamlog/config.hl ; \
	  echo $(PFBSTAMP) > chl-stamp ; \
	fi

jnames_encode_script:=\
  'use Encode;chomp;s/([\x{100}-\x{ffff}]+)/\
    "u___".unpack("H*",encode("utf8",$$1))."_"/ge;\
    if (/^\s*(\S+)\t(.*)/) { print "jk_name($$1,$$2).\n"; }'
hamlog/jnames.hl: txt/jnames.txt hamlog/.dirstamp
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD -ne $(jnames_encode_script) \
	  $(mvp)/txt/jnames.txt > hamlog/jnames.hl

hamlog/kddata.hl: tools/make-kddata $(KANJIDIC2) hamlog/.dirstamp
	$(TSU_V_PERL)
	$(AM_V_at)$(GZIP) -cd $(KANJIDIC2) \
	  | $(PERL) -CSD $(mvp)/tools/make-kddata \
	    > hamlog/kddata.hl

hamlog/macdep.ecl: tools/autodep hamlog/.dirstamp \
  $(sort $(wildcard $(mvp)/mp/*.mp) $(wildcard ./mp/*.mp))
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/autodep -mkpl $(mvp)/mp/ \
	  $(sort $(wildcard $(mvp)/mp/*.mp) $(wildcard ./mp/*.mp)) \
	  > hamlog/macdep.ecl

############################################################################

# MAKEFILE INCLUDES

# makefile-vars.inc needs to be early, is included by a hack at top of file
# makefile-pdf.inc needs to be late, and Automake does that by default

inc@andt@lude makefile-pfb.inc
inc@andt@lude makefile-pdf.inc
-inc@andt@lude makefile-maint.inc

family_xlat_script:=\
  's/, +/,/g;s/l___da//g;s/ +$$//;/\((.*),(.*)\)/;($$a,$$b)=($$1,$$2);\
    $$_="XLAT_$$a=$$b\n";s/s___e/ /g;s/h___en/-/g;s/([a-z])__/uc($$1)/ge;'
style_xlat_script:=\
  's/, +/,/g;s/l___da//g;s/,+/,/g;s/ +$$//;/\((.*),x___x,(.*)\)/;\
  ($$a,$$b)=($$1,$$2);$$a=~s/,+/_/g;$$a=~s/_$$//;$$b=~s/,+/ /g;\
  $$_="XLAT_$$a=$$b\n";s/s___e/ /g;s/h___en/-/g;s/([a-z])__/uc($$1)/ge;'
jkstyle_xlat_script:=\
  's/, +/,/g;s/l___da//g;s/,+/,/g;s/ +$$//;/\((.*),x___x,(.*)\)/;\
  ($$a,$$b)=($$1,$$2);$$a=~s/,+/_/g;$$a=~s/_$$//;$$b=~s/,+$$//;\
  $$_="JKXLAT_$$a=$$b\n";'
makefile-vars.inc: \
  hamlog/config.hl hamlog/select.hl hamlog/jnames.hl $(HAMLOG_DEPS)
	$(TSU_V_HAM)
	$(AM_V_at)echo '# GENERATED FILE, edit Makefile.am instead' \
	  > makefile-vars.inc ; \
	FAMILIES=`$(HAMLOG) 'FS' \
	  'family(FL),short_name(FL,FS)' \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER) \
	  | sed s/page//` ; \
	  echo FAMILIES=$$FAMILIES >> makefile-vars.inc ; \
	for f in $$FAMILIES; do \
	  echo PAGES_$$f=`$(HAMLOG) 'P' \
	    "short_name(F,$$f),page(P),want_char_on_page(P),want_page(F,P)" \
	    hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER) \
	    | sed s/page//` \
	    >> makefile-vars.inc ; \
	done
	$(AM_V_at)echo PAGES=`$(HAMLOG) 'P' \
	  "page_exists(Q,P),want_char_on_page(P)" \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER) \
	  | sed s/page//` \
	  >> makefile-vars.inc
	$(AM_V_at)echo OT_FEATURES=`$(HAMLOG) 'F' \
	  'feature_exists(F),want_feature(F)' \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER)` \
	  >> makefile-vars.inc
	$(AM_V_at)echo OVERLAY_TOKS=`$(HAMLOG) 'T' \
	  'overlay_fname(T)' \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER)` \
	  >> makefile-vars.inc
	$(AM_V_at)echo PARASITES=`$(HAMLOG) 'P' \
	  'parasite_available(P),want_parasite(P)' \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER)` \
	  >> makefile-vars.inc
	$(AM_V_at)echo SHORT_STYLES=`$(HAMLOG) 'want_style_short(F,S,W,P)' \
	  'want_style_short(F,S,W,P)' \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER) \
	  | $(PERL) -CSD -pe \
	  's/, +/,/g;s/^.*\((.*)\).*$$/$$1 /;s/l___da//g;s/,+/_/g;s/_ / /;'` \
	  >> makefile-vars.inc
	$(AM_V_at)echo PROOF_STYLES=`$(HAMLOG) 'proof_style_short(F,S,W,P)' \
	  'proof_style_short(F,S,W,P)' \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER) | \
	  $(PERL) -CSD -pe \
	  's/, +/,/g;s/^.*\((.*)\).*$$/$$1 /;s/l___da//g;s/,+/_/g;s/_ / /;'` \
	  >> makefile-vars.inc
	$(AM_V_at)$(HAMLOG) 'family_xlat(FS,FL)' \
	  'family(F),short_name(F,FS),long_name(F,FL)' \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER) \
	  | $(PERL) -CSD -pe $(family_xlat_script) \
	  >> makefile-vars.inc
	$(AM_V_at)$(HAMLOG) 'style_xlat(F,S,W,P,x___x,FX,SX,WX,PX)' \
	  'style_xlat(F,S,W,P,x___x,FX,SX,WX,PX)' \
	  hamlog/config.hl $(mvp)/hamlog/select.hl $(HAMLOG_AFTER) \
	  | $(PERL) -CSD -pe $(style_xlat_script) \
	  >> makefile-vars.inc
	$(AM_V_at)$(HAMLOG) 'style_jkxlat(F,S,W,P,x___x,FX,SX,WX,PX)' \
	  'style_jkxlat(F,S,W,P,x___x,FX,SX,WX,PX)' \
	  hamlog/config.hl hamlog/jnames.hl \
	  $(mvp)/hamlog/select.hl $(HAMLOG_AFTER) \
	  | $(PERL) -CSD -pe $(jkstyle_xlat_script) \
	  >> makefile-vars.inc

pfdf=$(subst -, ,$(notdir $(basename $(1))))
pfms=$(filter $(DEFAULT_TOK) $(OVERLAY_TOKS),$(call pfdf,$(1)))
PFBDEPS=$(foreach term,\
  $(filter-out $(DEFAULT_TOK) $(OVERLAY_TOKS),$(call pfdf,$(1))),\
  $(if $(wildcard $(mvp)/mp/$(call pfms,$(1))-$(term).mp),\
  $(call pfms,$(1)),$(if $(wildcard ./mp/$(call pfms,$(1))-$(term).mp),\
  $(call pfms,$(1)),$(DEFAULT_TOK)))-$(term).mp)

KANJIPAGES:=$(strip 2e 2f 4e 4f $(foreach hinib,5 6 7 8 9,\
  $(foreach lonib,0 1 2 3 4 5 6 7 8 9 a b c d e f,$(hinib)$(lonib) )))

PAGEFILES=$(strip $(foreach page,\
  $(PAGES_$(firstword $(subst _,$(space),$(2)))),\
  $(if $(or $(wildcard $(mvp)/mp/$(DEFAULT_TOK)-$(page).mp),\
    $(wildcard $(mvp)/mp/$(firstword $(subst _,$(space),$(2)))-$(page).mp),\
    $(wildcard ./mp/$(DEFAULT_TOK)-$(page).mp),\
    $(wildcard ./mp/$(firstword $(subst _,$(space),$(2)))-$(page).mp)),\
    $(1)$(subst _,-,$(2))-$(page)$(3))))

MAYBE_PFB_TICKLER:=\
  $(if $(filter-out x$(PFBSTAMP),x$(shell cat pfb-stamp* | sort | uniq)),\
    pfb-tickler)

pfb-tickler:

.PHONY: pfb-tickler

makefile-pfb.inc: \
  makefile-vars.inc tools/mpdep mp/.hglstamp \
  $(sort $(wildcard $(mvp)/mp/*.mp) $(wildcard ./mp/*.mp)) \
  $(MAYBE_PFB_TICKLER)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -o makefile-pfb.inc \
	  makefile-pfb-0.inc makefile-pfb-1.inc \
	  makefile-pfb-2.inc makefile-pfb-3.inc \
	  makefile-pfb-4.inc makefile-pfb-5.inc \
	  makefile-pfb-6.inc makefile-pfb-7.inc
	$(AM_V_at)cat makefile-pfb-?.inc > makefile-pfb.inc

makefile-pfb-%.inc: \
  makefile-vars.inc tools/mpdep mp/.hglstamp \
  $(sort $(wildcard $(mvp)/mp/*.mp) $(wildcard ./mp/*.mp)) \
  $(MAYBE_PFB_TICKLER)
	$(AM_V_at)if ( test "x$(PFBSTAMP)" = "x`cat pfb-stamp-$*`" ) \
	  && ( test -s makefile-pfb-$*.inc ) ; then \
	  $(TSU_V_NASKIP) \
	  true ; \
	else \
	  $(TSU_V_NAPERL) \
	  export PROGRESS_MESSAGE="$(ansi_cleareol)@@@$@" ; \
	  echo '# GENERATED FILE, edit Makefile.am instead' \
	    > makefile-pfb-$*.inc ; \
	  $(PERL) -CSD $(mvp)/tools/progress start makefile-pfb-$* \
	    `ls $(mvp)/mp/*.mp ./mp/*.mp | \
	    $(PERL) -ne 'print "$$1\n" if /-([0-9a-f]{2,3})\.mp/;' | \
	    sort | uniq | \
	    $(PERL) -ne 'print if ($$i++%16%14%8)==$*' | \
	    wc -l` ; \
	  for page in `ls $(mvp)/mp/*.mp ./mp/*.mp | \
	    $(PERL) -ne 'print "$$1\n" if /-([0-9a-f]{2,3})\.mp/;' | \
	    sort | uniq | \
	    $(PERL) -ne 'print if ($$i++%16%14%8)==$*'`; do \
	    for style in $(subst _,-,$(SHORT_STYLES)); do \
	      echo pfbtmp/$$style-$$page.pfb prf/$$style-$$page.prf: \
	`$(PERL) -CSD $(mvp)/tools/mpdep $(DEFAULT_TOK) $$style-$$page` \
	        >> makefile-pfb-$*.inc ; \
	      echo >> makefile-pfb-$*.inc ; \
	    done ; \
	    $(PERL) -CSD $(mvp)/tools/progress count makefile-pfb-$* ; \
	  done ; \
	  echo $(PFBSTAMP) > pfb-stamp-$* ; \
	fi

############################################################################

# DIRSTAMPS

area/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) area
	$(AM_V_at)echo directory created > area/.dirstamp

bdf/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) bdf
	$(AM_V_at)echo directory created > bdf/.dirstamp

doc/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) doc
	$(AM_V_at)$(LN_S) -f `which $(PERL)` doc/wdperl
	$(AM_V_at)$(LN_S) -f $(abspath $(mvp)/tools/progress) doc/wdprogress
	$(AM_V_at)echo directory created > doc/.dirstamp

fea/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) fea
	$(AM_V_at)echo directory created > fea/.dirstamp

hamlog/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) hamlog
	$(AM_V_at)echo directory created > hamlog/.dirstamp

mp/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) mp
	$(AM_V_at)echo directory created > mp/.dirstamp

otf/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) otf
	$(AM_V_at)echo directory created > otf/.dirstamp

pe/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) pe
	$(AM_V_at)echo directory created > pe/.dirstamp

pfb/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) pfb
	$(AM_V_at)echo directory created > pfb/.dirstamp

pfbtmp/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) pfbtmp
	$(AM_V_at)echo directory created > pfbtmp/.dirstamp

prf/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) prf
	$(AM_V_at)echo directory created > prf/.dirstamp

sfd/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) sfd
	$(AM_V_at)echo directory created > sfd/.dirstamp

sum/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) sum
	$(AM_V_at)echo directory created > sum/.dirstamp

txt/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) txt
	$(AM_V_at)echo directory created > txt/.dirstamp

############################################################################

# STUB PAGE FILES FOR HANGUL SYLLABLES

mp/.hglstamp: mp/.dirstamp tools/make-hglpages
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-hglpages > mp/.hglstamp

############################################################################

# FONT LOG

pe/make-empty.pe: pe/.dirstamp
	$(AM_V_GEN)
	$(AM_V_at)echo '#!'$(FONTFORGE) > pe/make-empty.pe
	$(AM_V_at)echo 'New();Save("sfd/empty.sfd");' >> pe/make-empty.pe

sfd/empty.sfd: sfd/.dirstamp pe/make-empty.pe
	$(AM_V_GEN)
	$(AM_V_at)$(FONTFORGE) pe/make-empty.pe $(TSU_V_REDIR)

txt/fontlog.txt: txt/.dirstamp tools/make-flog \
  hamlog/config.hl makefile-vars.inc
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-flog > txt/fontlog.txt

sfd/flogged.sfd: sfd/empty.sfd txt/fontlog.txt
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/add-flog \
	  sfd/empty.sfd txt/fontlog.txt > sfd/flogged.sfd

############################################################################

# POSTSCRIPT FONTS

FWPSFONTS=$(foreach st,$(filter-out %_ps,$(SHORT_STYLES)),\
  $(call PAGEFILES,pfbtmp/,$(st),.pfb))
PSPSFONTS=$(foreach st,$(filter %_ps,$(SHORT_STYLES)),\
  $(call PAGEFILES,pfbtmp/,$(st),.pfb))
ALLPSFONTS=$(FWPSFONTS) $(PSPSFONTS)

ALLPRFS=$(foreach st,$(PROOF_STYLES),$(call PAGEFILES,prf/,$(st),.prf))

pfbtmp/%.pfb prf/%.prf: pfbtmp/.dirstamp prf/.dirstamp sum/.dirstamp \
  tools/livecode tools/mp2pf t1asm/t1asm
	$(AM_V_at)CODESTAMP=`$(PERL) -CSD $(mvp)/tools/livecode \
	  $(foreach fn,$(call PFBDEPS,pfbtmp/$*.pfb),$(mvp)/mp/$(fn)) \
	  | $(CHECKSUM)` ; \
	if ( test -s $@ ) && ( test -s sum/$*.sum ) && \
	  ( test "x$$CODESTAMP" = "x`cat sum/$*.sum`" ) ; then \
	  $(TSU_V_NASKIP) \
	  touch $@ ; \
	else \
	  $(TSU_V_MT1) \
	  $(MKDIR_P) $*.tmp ; \
	  $(LN_S) -f $(realpath $(mvp))/mp/*.mp $*.tmp/ ; \
	  $(LN_S) -f $(realpath .)/mp/*.mp $*.tmp/ ; \
	  if test -r $(realpath $(mvp))/mp/$*.mp \
	    || test -r $(realpath .)/mp/$*.mp; then \
	    echo "STUB MP FILE ALREADY EXISTS BUILDING" $@ ; \
	    exit 1 ; \
	  else \
	    echo \
	      "string pagename; " \
	      "pagename=\"$(lastword $(subst -,$(space),$*))\"; " \
	      "$(foreach fn,$(call PFBDEPS,pfbtmp/$*.pfb),input $(fn);)" \
	      > $*.tmp/$*.mp ; \
	  fi ; \
	  (cd $*.tmp ; $(expect_start)$(MPOST) $*.mp$(expect_end) ) ; \
	  if $(GREP) -q '^! ' $*.tmp/$*.log ; then exit 1 ; fi ; \
	  $(TSU_V_NAPERL) \
	  $(PERL) -CSD $(mvp)/tools/mp2pf $*.tmp/$* $(TSU_V_REDIR) ; \
	  (cd $*.tmp ; ../t1asm/t1asm -b $*.p $*.pfb ) ; \
	  if test -r $*.tmp/$*.pfb \
	    && $(GREP) -q 'output files\? written' $*.tmp/$*.log; then \
	    mv -f $*.tmp/$*.pfb pfbtmp/ ; \
	    echo "$$CODESTAMP" > sum/$*.sum ; \
	  else \
	    echo "ERROR BUILDING" $@ ; \
	    exit 1 ; \
	  fi ; \
	  if ( test -r $*.tmp/proof.prf ) \
	    && ( test '!' x$(findstring $*,$(ALLPRFS)) = x) ; then \
	    mv -f $*.tmp/proof.prf prf/$*.prf ; \
	  fi ; \
	  if test "x$(KEEPTMP)" = "x" ; then \
	    rm -rf $*.tmp ; \
	  fi ; \
	fi

pfb/%.pfb: pfbtmp/%.pfb pfb/.dirstamp sum/.dirstamp pe/rmo.pe tools/livecode
	$(AM_V_at)CODESTAMP=`$(PERL) -CSD $(mvp)/tools/livecode \
	  $(foreach fn,$(call PFBDEPS,pfbtmp/$*.pfb),$(mvp)/mp/$(fn)) \
	  | $(CHECKSUM)` ; \
	if ( test "pfb/$*.pfb" -nt "sum/$*.sum" ) ; then \
	  $(TSU_V_NASKIP) \
	  touch pfb/$*.pfb ; \
	else \
	  $(TSU_V_RMO) \
	  $(FONTFORGE) $(mvp)/pe/rmo.pe pfbtmp/$*.pfb pfb/$*.pfb \
	    $(TSU_V_REDIR) ; \
	fi

pfbtmp: $(ALLPSFONTS)

pfb: $(subst pfbtmp/,pfb/,$(ALLPSFONTS))

.PHONY: pfbtmp pfb

############################################################################

# OPENTYPE FONTS

chars.lst: hamlog/config.hl hamlog/select.hl $(HAMLOG_DEPS) $(MAYBE_KDDATA)
	$(TSU_V_HAM)
	$(AM_V_at)$(HAMLOG) 'C' \
	  'page_exists(Q,P),char_page(C,P),want_char(C,P)' \
	  hamlog/config.hl $(MAYBE_KDDATA) $(mvp)/hamlog/select.hl \
	  $(HAMLOG_AFTER) > chars.lst

pe/assemble-font.pe tsukurimashou.nam: \
  pe/.dirstamp tools/make-ass chars.lst \
  $(sort $(foreach page,$(PAGES),\
    $(wildcard $(mvp)/mp/*-$(page).mp) $(wildcard ./mp/*-$(page).mp)))
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-ass > pe/assemble-font.pe

fea/%.fea: \
  fea/.dirstamp fsc/%.fsc tools/make-fea \
  makefile-vars.inc chars.lst \
  fsc/afrc.fsc fsc/misc.fsc fsc/ss01.fsc fsc/ss02.fsc \
  fsc/hangul.fsc fsc/kanapc.fsc fsc/latinpc.fsc
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-fea "$(OT_FEATURES)" \
	  $(mvp)/fsc/$*.fsc > fea/$*.fea

fea/bll.fea: fsc/tsuku.fsc

fea/jieub.fea: fsc/hangul.fsc

fea/tsuita.fea: fsc/tsuku.fsc

define NAME_RECIPE
fea/$(subst _,-,$1)-name.fea: fea/.dirstamp tools/make-name makefile-vars.inc
	$$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-name "$(OT_FEATURES)" \
	  "$(XLAT_$(word 1,$(subst _,$(space),$1)))" \
	  "$(XLAT_$1)" \
	  "$(JKXLAT_$1)" \
	  > fea/$(subst _,-,$1)-name.fea
endef

$(foreach style,$(SHORT_STYLES), \
  $(eval $(call NAME_RECIPE,$(style))))

define NKOTF_RECIPE
otf/$(subst -,,$(subst $(space),,$(XLAT_$1))).otf: otf/.dirstamp \
  sfd/.dirstamp doc/.dirstamp makefile-vars.inc \
  sfd/flogged.sfd \
  pe/assemble-font.pe fea/$(word 1,$(subst _,$(space),$1)).fea \
  tsukurimashou.nam \
  fea/monospace.fea fea/$(subst _,-,$1)-name.fea \
  $(call PAGEFILES,pfb/,$(1),.pfb)
	$(TSU_V_OTF) otf/$(subst -,,$(subst $(space),,$(XLAT_$1))).otf
	$(AM_V_at)$(FONTFORGE) pe/assemble-font.pe \
	    $(subst _,-,$1) \
	    "$(XLAT_$(word 1,$(subst _,$(space),$1)))" \
	    "$(XLAT_$1)" \
	  $(if $(AM_V_at), \
	    2> /dev/null | $(PERL) -CDS $(mvp)/tools/progress stdin \
	    otf/$(subst -,,$(subst $(space),,$(XLAT_$1))).otf \
	    "$(ansi_cleareol)", \
	    $(TSU_V_REDIR))

endef

$(foreach style,$(filter-out %_ps,$(SHORT_STYLES)), \
  $(eval $(call NKOTF_RECIPE,$(style))))

define KERN_RECIPE
sfd/$(subst _,-,$1).sfd: \
  sfd/.dirstamp doc/.dirstamp makefile-vars.inc \
  sfd/flogged.sfd \
  pe/assemble-font.pe fea/$(word 1,$(subst _,$(space),$1)).fea \
  tsukurimashou.nam \
  fea/$(subst _,-,$1)-name.fea \
  $(call PAGEFILES,pfb/,$(1),.pfb)
	$(TSU_V_SFD) sfd/$(subst _,-,$1).sfd
	$(AM_V_at)$(FONTFORGE) pe/assemble-font.pe \
	    $(subst _,-,$1) \
	    "$(XLAT_$(word 1,$(subst _,$(space),$1)))" \
	    "$(XLAT_$1)" \
	  $(if $(AM_V_at), \
	    2> /dev/null | $(PERL) -CDS $(mvp)/tools/progress stdin \
	    sfd/$(subst _,-,$1).sfd \
	    "$(ansi_cleareol)", \
	    $(TSU_V_REDIR))

bdf/$(subst -,,$(subst $(space),,$(XLAT_$1))).bdf: \
  bdf/.dirstamp pe/bdf.pe sfd/$(subst _,-,$1).sfd
	$(TSU_V_BDF) bdf/$(subst -,,$(subst $(space),,$(XLAT_$1))).bdf
	$(AM_V_at)$(FONTFORGE) $(mvp)/pe/bdf.pe \
	  $(subst -,,$(subst $(space),,$(XLAT_$1))) $(subst _,-,$1) \
	  $(TSU_V_REDIR)
	$(AM_V_at)mv -f \
	  bdf/$(subst -,,$(subst $(space),,$(XLAT_$1)))-100.bdf \
	  bdf/$(subst -,,$(subst $(space),,$(XLAT_$1))).bdf

# this rule also, silently, builds the *-bearing.pe script
fea/$(subst _,-,$1)-ktmp.fea: \
  bdf/$(subst -,,$(subst $(space),,$(XLAT_$1))).bdf \
  kerner/kerner pe/.dirstamp fea/.dirstamp
	$(TSU_V_KERN) fea/$(subst _,-,$1)-ktmp.fea
	$(AM_V_at)kerner/kerner \
	  bdf/$(subst -,,$(subst $(space),,$(XLAT_$1))).bdf \
	  kerner/kerner.cfg \
	  pe/$(subst _,-,$1)-bearing.pe \
	  fea/$(subst _,-,$1)-ktmp.fea \
	  $(TSU_V_REDIR)

fea/$(subst _,-,$1)-kern.fea: \
  fea/$(subst _,-,$1)-ktmp.fea \
  fea/$(word 1,$(subst _,$(space),$1)).fea \
  sfd/$(subst _,-,$1).sfd \
  pe/getbearings.pe tools/make-gpos
	$(TSU_V_KERN) fea/$(subst _,-,$1)-kern.fea
	$(AM_V_at)$(FONTFORGE) $(mvp)/pe/getbearings.pe \
	  sfd/$(subst _,-,$1).sfd \
	  $(TSU_V_REDIR) > $1.bearings 
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-gpos "$(OT_FEATURES)" \
	  $1.bearings pe/$(subst _,-,$1)-bearing.pe \
	  $(call PAGEFILES,prf/,$(1),.prf) > fea/$(subst _,-,$1)-gpos.fea
	$(AM_V_at)cat fea/$(word 1,$(subst _,$(space),$1)).fea \
	  fea/$(subst _,-,$1)-ktmp.fea \
	  fea/$(subst _,-,$1)-gpos.fea > fea/$(subst _,-,$1)-kern.fea
	$(AM_V_at)rm -f $1.bearings

otf/$(subst -,,$(subst $(space),,$(XLAT_$1))).otf: otf/.dirstamp \
  fea/$(subst _,-,$1)-ktmp.fea fea/$(subst _,-,$1)-kern.fea \
  pe/kern-font.pe sfd/$(subst _,-,$1).sfd
	$(TSU_V_OTF) \
	  otf/$(subst -,,$(subst $(space),,$(XLAT_$1))).otf
	$(AM_V_at)$(FONTFORGE) $(mvp)/pe/kern-font.pe \
	  $(subst _,-,$1) \
	  "$(XLAT_$(word 1,$(subst _,$(space),$1)))" \
	  "$(XLAT_$1)" \
	  $(TSU_V_REDIR)

endef

$(foreach style,$(filter %_ps,$(SHORT_STYLES)), \
  $(eval $(call KERN_RECIPE,$(style))))

otf: $(foreach style,$(SHORT_STYLES),\
  otf/$(subst -,,$(subst $(space),,$(XLAT_$(style)))).otf)

.PHONY: otf

############################################################################

# GENERAL PDF DOCUMENTATION

if COND_PGFWORKAROUND
doc/pgflibraryshapes.callouts.code.tex:
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD -pe 's/pgf\@test/pgf\@node\@name/g' \
	  `kpsewhich pgflibraryshapes.callouts.code.tex` \
	  > doc/pgflibraryshapes.callouts.code.tex

MAYBE_PGFLIBSHAPES=doc/pgflibraryshapes.callouts.code.tex
endif

doc_font_script := $(PERL) -CSD -e \
  'while (<>) { chomp; while (/%\s*$$/) { $$_.=<>; chomp; } if (\
  /(newfontfamily|newfontface|setmainfont|setmonofont).*\{([^{}]+)\}+\s*$$/\
  ) { $$d{"otf/$$2.otf"}=1; } } print join(" ",keys %d);'
filter_demo_deps = $(filter $(strip $(foreach st,$(SHORT_STYLES), \
    otf/$(subst -,,$(subst $(space),,$(XLAT_$(st)))).otf)),$1)
makefile-pdf.inc: makefile-vars.inc \
  doc/demo.tex doc/usermanual.tex doc/proofs.tex doc/bkstyle.tex \
  tools/make-kchart $(MAYBE_KANJIDIC2)
	$(TSU_V_PERL)
	$(AM_V_at)for doc in proofs $(MAINTAINER_DOCS); do \
	  FDEPS=`$(doc_font_script) $(mvp)/doc/$$doc.tex` ; \
	  echo doc/$$doc.xdv doc/$$doc.toc doc/$$doc.aux: \
	    $(mvp)/doc/$$doc.tex $$FDEPS >> makefile-pdf.inc ; \
	  echo >> makefile-pdf.inc ; \
	  echo doc/$$doc.pdf: $$FDEPS >> makefile-pdf.inc ; \
	  echo >> makefile-pdf.inc ; \
	done
	$(AM_V_at)FDEPS=`$(doc_font_script) $(mvp)/doc/demo.tex` ; \
	echo doc/demo.xdv doc/demo.toc doc/demo.aux: $(mvp)/doc/demo.tex \
	  '$$('call filter_demo_deps,$$FDEPS')' >> makefile-pdf.inc ; \
	echo >> makefile-pdf.inc ; \
	echo doc/demo.pdf: '$$('call filter_demo_deps,$$FDEPS')' \
	  >> makefile-pdf.inc ; \
	echo >> makefile-pdf.inc
	$(AM_V_at)FDEPS=`$(doc_font_script) $(mvp)/doc/usermanual.tex` ; \
	echo doc/usermanual.xdv doc/usermanual.toc doc/usermanual.aux: \
	  $(mvp)/doc/usermanual.tex \
	  '$$('call filter_demo_deps,$$FDEPS')' >> makefile-pdf.inc ; \
	echo >> makefile-pdf.inc ; \
	echo doc/usermanual.pdf: '$$('call filter_demo_deps,$$FDEPS')' \
	  >> makefile-pdf.inc ; \
	echo >> makefile-pdf.inc
	$(AM_V_at)FDEPS=`$(doc_font_script) $(mvp)/tools/make-kchart` ; \
	echo doc/kanjichart.xdv: doc/kanjichart.tex $$FDEPS \
	  >> makefile-pdf.inc ; \
	echo >> makefile-pdf.inc ; \
	echo doc/kanjichart.pdf: doc/kanjichart.xdv $$FDEPS \
	  >> makefile-pdf.inc ; \
	echo >> makefile-pdf.inc
	$(AM_V_at)FDEPS=`$(doc_font_script) $(mvp)/doc/bkstyle.tex` ; \
	echo doc/pprinted.tex: $$FDEPS >> makefile-pdf.inc ; \
	echo >> makefile-pdf.inc ; \
	for rn in I II III IV V VI VII VIII IX X \
	  XI XII XIII XIV XV XVI XVII XVIII XIX XX ; do \
	  echo doc/book$$rn.xdv: doc/book$$rn.tex doc/bkstyle.tex \
	    doc/proofs.aux $(MAYBE_PGFLIBSHAPES) $$FDEPS \
	    >> makefile-pdf.inc ; \
	  echo >> makefile-pdf.inc ; \
	  echo doc/book$$rn.pdf: doc/book$$rn.xdv $$FDEPS \
	    >> makefile-pdf.inc ; \
	  echo >> makefile-pdf.inc ; \
	  echo doc/cover$$rn.tex: doc/book$$rn.log \
	    >> makefile-pdf.inc ; \
	  echo >> makefile-pdf.inc ; \
	  echo doc/cover$$rn.xdv: doc/cover$$rn.tex $$FDEPS \
	    >> makefile-pdf.inc ; \
	  echo >> makefile-pdf.inc ; \
	  echo doc/cover$$rn.pdf: doc/cover$$rn.xdv $$FDEPS \
	    >> makefile-pdf.inc ; \
	  echo >> makefile-pdf.inc ; \
	done

nocomma_date:=$(subst $(comma),,@release_date@)
doc/version.tex: hamlog/config.hl
	$(AM_V_GEN)
	$(AM_V_at)echo '\def\TsukurimashouVersion{'$(VERSION)'}' \
	  > doc/version.tex
	$(AM_V_at)echo '\def\TsukurimashouVWide{'$(VERSION)'}' \
	  | $(PERL) -CSD -pe \
	    'tr/0-9./\x{ff10}-\x{ff19}\x{ff0e}/;s/pre/\x{30d7}\x{30ea}/;' \
	  >> doc/version.tex
	$(AM_V_at)echo '\def\TsukurimashouReleaseDate{@release_date@}' \
	  >> doc/version.tex
	$(AM_V_at)echo '\def\TsukurimashouRDWide{'`date -d \
	    "$(nocomma_date)" "+%YX%-mY%-dZ"`'}' \
	  | $(PERL) -CSD -pe \
	    'tr/0-9XYZ/\x{ff10}-\x{ff19}\x{5e74}\x{6708}\x{65e5}/' \
	  >> doc/version.tex
	$(AM_V_at)for st in $(foreach st,$(SHORT_STYLES), \
	  $(subst -,,$(subst $(space),,$(XLAT_$(st))))) ; do \
	  echo '\def\have'$$st'{Y}' >> doc/version.tex ; \
	done

doc/%.xdv doc/%.toc doc/%.aux doc/%.log: \
  doc/%.tex doc/.dirstamp doc/version.tex
	$(TSU_V_TEX)
	$(AM_V_at)(cd doc ; \
	  rm -f $*.aux $*.out ; \
	  echo "\\tsukudrafttrue" > $*-draft.tex ; \
	  export PROGRESS_MESSAGE=$@ ; \
	  $(expect_start)$(XELATEX) -shell-escape -no-pdf \
	    $(realpath $<) $(expect_end) )
	$(AM_V_at)(cd doc ; \
	  I=2 ; cp -f $*.xdv $*.bak ; \
	  until $(TSU_V_TEXL) \
	  export PROGRESS_MESSAGE="$@($$I)" ; \
	  case "$$I""$*" in \
	    $(PROOF_ND_PASS)proofs) \
	      echo "\\tsukudraftfalse" > $*-draft.tex ;; \
	    2book*) echo "\\tsukudraftfalse" > $*-draft.tex ;; \
	  esac ; \
	  $(expect_start)$(XELATEX) -shell-escape -no-pdf \
	    $(realpath $<) $(expect_end) ; \
	  test "x`$(GREP) may.have.changed $*.log`" = "x" ; \
	  do cp -f $*.xdv $*.bak; I=$$(($$I+1)) ; done ; \
	  rm -f $*.bak )

doc/%.pdf: doc/%.xdv
	$(TSU_V_TEX)
	$(AM_V_at)(cd doc ; \
	  $(XDVIPDFMX) $*.xdv $(TSU_V_REDIR) )

doc/kanjichart.tex: tools/make-kchart pe/assemble-font.pe \
  txt/tsukurimashou.eids
	$(TSU_V_PERL)
	$(AM_V_at)$(GZIP) -cd $(KANJIDIC2) \
	  | $(PERL) -CSD $(mvp)/tools/make-kchart \
	  $(mvp)/pe/assemble-font.pe \
	    > doc/kanjichart.tex

pdf-local: $(MAYBE_DOCS) $(MAYBE_MDOCS) $(MAYBE_KANJI_CHART)

############################################################################

# PROOFS

doc/pprinted.tex: tools/make-proof $(ALLPRFS) \
  $(sort $(wildcard $(mvp)/mp/*.mp) $(wildcard ./mp/*.mp))
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-proof > doc/pprinted.tex

doc/pppcount.tex: doc/pprinted.tex
	$(AM_V_GEN)
	$(AM_V_at)$(GREP) '\\def\\ProgressCount' \
	  doc/pprinted.tex > doc/pppcount.tex

doc/proofs.pdf: doc/proofs.xdv

doc/proofs.xdv doc/proofs.toc doc/proofs.aux: \
  doc/proofs.tex doc/pprinted.tex doc/pppcount.tex $(MAYBE_PGFLIBSHAPES)

doc/cooked.aux: doc/proofs.aux
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD -ne \
	  's/section\*\.\d+//; print if /^\\newlabel/' \
	  doc/proofs.aux > doc/cooked.aux

doc/book%.tex: tools/make-book doc/cooked.aux
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-book \
	  doc/book $@ doc/proofs.toc

doc/cover%.tex: tools/make-cover doc/book%.log
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-cover \
	  doc/book$*.log > $@

EIDSPRFS=$(foreach page,$(KANJIPAGES),\
  $(if $(wildcard $(mvp)/mp/tsuku-$(page).mp),\
    prf/tsuku-kg-$(page).prf))

txt/tsukurimashou.eids: tools/make-eids $(EIDSPRFS)
	$(TSU_V_PERL)
	$(AM_V_at)$(PERL) -CSD $(mvp)/tools/make-eids $(EIDSPRFS) \
	  > txt/tsukurimashou.eids

eids: txt/tsukurimashou.eids

.PHONY: eids

############################################################################

# BEFORE/AFTER PROCESSING AREA VERIFICATION

area/%-before.area: area/.dirstamp pfbtmp/%.pfb pe/makepngs.pe sfd/empty.sfd
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) $*.tmp ; \
	(cd $*.tmp ; \
	  $(FONTFORGE) $(realpath $(mvp))/pe/makepngs.pe \
	     $(realpath .)/pfbtmp/$*.pfb $(TSU_V_REDIR) ; \
	  for f in *.png ; do echo -n "$$f" ; pngtopnm $$f | \
	    pgmtopbm -threshold | pgmhist | \
	    grep '^    0' ; echo ' 0 0' ; done | \
	    $(PERL) -pe \
	'$$_="$*-$$_"; s/-([0-9a-f]+)-(.*)\.png\s+0\s+(\d+).*/-$$2 $$3/;' \
	  | sort -u > $(realpath .)/area/$*-before.area \
	) ; \
	if test "x$(KEEPTMP)" = "x" ; then \
	  rm -rf $*.tmp ; \
	fi

area/%-after.area: area/.dirstamp sfd/%.sfd pe/makepngs.pe sfd/empty.sfd
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) $*.tmp ; \
	(cd $*.tmp ; \
	  $(FONTFORGE) $(realpath $(mvp))/pe/makepngs.pe \
	     $(realpath .)/sfd/$*.sfd $(TSU_V_REDIR) ; \
	  for f in *.png ; do echo -n "$$f" ; pngtopnm $$f | \
	    pgmtopbm -threshold | pgmhist | \
	    grep '^    0' ; echo ' 0 0' ; done | \
	    $(PERL) -pe \
	'$$_="$*-$$_"; s/\.png\s+0\s+(\d+).*/ $$1/;' \
	  | sort -u > $(realpath .)/area/$*-after.area \
	) ; \
	if test "x$(KEEPTMP)" = "x" ; then \
	  rm -rf $*.tmp ; \
	fi

txt/area-problems.txt: \
  $(foreach style,$(SHORT_STYLES), area/$(subst _,-,$(style))-after.area \
    $(call PAGEFILES,area/,$(style),-before.area))
	$(AM_V_GEN)
	$(AM_V_at)( for style in \
	  $(foreach style,$(SHORT_STYLES), $(subst _,-,$(style))) ; do \
	  cat area/$$style-[0-9a-f][0-9a-f]-before.area \
	    area/$$style-[0-9a-f][0-9a-f][0-9a-f]-before.area | sort | \
	  join - area/$$style-after.area | \
	  perl -nae 'print if $$F[2]>0.8*$$F[1]+100' ; \
	done ) | sort > txt/area-problems.txt

check-areas: txt/area-problems.txt

.PHONY: check-areas

############################################################################

# TESTING

TESTS = $(dist_otf_DATA)
TEST_EXTENSIONS = .otf
OTF_LOG_COMPILER = $(FONTFORGE) $(mvp)/pe/fontlint.pe $(FONTLINT_FLAGS)

############################################################################

# AUTOMAKE'S RULES WILL GO HERE

automake_rules = here

############################################################################
