#!/usr/bin/perl

$fail=0;

open(SCC,'fontanvil/scripting.c');
while (<SCC>) {
  if (/\} builtins\[\]=\{/) {
    $capturing=1;
  } elsif (/\{NULL,/) {
    $capturing=0;
  }
  if ($capturing && /\{"(\w+)",/) {
    push @builtins,$1;
  }
}
close(SCC);

open(REF,'doc/reference.tex');
while (<REF>) {
  if (/^\\PEFuncRef\{(\w+)\}/) {
    $fn=$1;
  } elsif (/%%%%/) {
    $fn='';
  } elsif (/^[A-Z]/ && ($fn ne '')) {
    $num_docd++ unless $docd{$fn};
    $docd{$fn}=1;
  }
}
close(REF);

printf "%d of %d builtin functions documented in reference manual "
  ."(%.02f%%).\n",$num_docd,$#builtins+1,100*$num_docd/($#builtins+1);
if ($num_docd<$#builtins+1) {
  $fail=1;
  print "Those not documented:\n";
  foreach $fn (@builtins) {
    print "  $fn\n" if !$docd{$fn};
  }
}

foreach $file (<doc/*.tex>) {
  open(DOC,$file);
  while (<DOC>) {
    if (/FIXME/) {
      $fail=1;
      $fixmes{$file}++;
      $total_fixmes++;
    }
  }
  close(DOC);
}

if ($total_fixmes>0) {
  printf "%d FIXME%s in documentation TeX files\n",
    $total_fixmes,$total_fixmes>1?'s':'';
  foreach $file (sort keys %fixmes) {
    printf "  %d in %s\n",$fixmes{$file},$file;
  }
}

exit $fail;
