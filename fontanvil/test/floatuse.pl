#!/usr/bin/perl

exit(77) if $ENV{'distcheck_hack'} eq '0.4';

$exitcode=0;

while (<*/*.[ch]>) {
  $source=$_;
  open(SOURCE,$source);
  $lineno=0;
  while (<SOURCE>) {
    chomp;
    $lineno++;

    if (/^\S/) {
      undef %realvars;
      $realvars{'minx'}=1;
      $realvars{'maxx'}=1;
      $realvars{'miny'}=1;
      $realvars{'maxx'}=1;
    };
    
    if (/^\s*(float|double)\s(.*)$/) {
      $decls=$2;
      while ($decls=~/\b([a-z][a-z0-9_]*)\s*[,;=\[]/ig) {
        $realvars{$1}=1;
      }
    }

    $exactint=0;
    while (/\b([a-z][a-z0-9_]*)(\[.{1,10}\])?\s*[<>!]=\s*(\d+)[^\.]/ig) {
      $exactint=1 if $realvars{$1};
    }
    while (/(.)([^0-9e\.])\d+\s*[<>!]=\s*([a-z][a-z0-9_]*)\b/ig) {
      next if (($1 eq 'e') || ($1 eq 'E')) && (($2 eq '+') || ($2 eq '-'));
      $exactint=1 if $realvars{$3};
    }

    $exacteq=0;
    while (/\b([a-z][a-z0-9_]*)(\[.{1,10}\])?\s*==/ig) {
      $exacteq=1 if $realvars{$1};
    }
    while (/==\s*([a-z][a-z0-9_]*)\b/ig) {
      $exacteq=1 if $realvars{$1};
    }

    $floatmagic=0;
    $floatmagic=1 if /FLOATMAGIC/;
    if ($exactint || $exacteq || $floatmagic) {
      $exitcode=1;
      if ($source ne $warned_file) {
        print "$source:\n";
        $warned_file=$source;
      }
      printf "%9d: %s\n",$lineno,$_;
      print "   comparison of real against integer\n" if $exactint;
      print "   exact equality of reals\n" if $exacteq;
    }
  }
  close(SOURCE);
}

exit($exitcode);
