#!/usr/bin/perl

while (<test/*.log>) {
  open(LOGFILE,$_);
  $state=0;
  while (<LOGFILE>) {
    chomp;
    last if /Aggregated built-in function call counts/;
    if (/-----BEGIN FONTANVIL COVERAGE COUNTS-----/) {
      $state=1;
    } elsif (($state==1) && (/^([A-Z0-9_]+) +(\d+)$/i)) {
      $calls{$1}+=$2;
    } else {
      $state=0;
    }
  }
  close(LOGFILE);
}

print (('='x51)."\n");
print "Aggregated built-in function call counts\n";
print (('='x51)."\n");
$totcalls=0;
$numfuncs=0;
$numcovd=0;
foreach $bi (sort keys %calls) {
  printf "%-30s %20lu\n",$bi,$calls{$bi};
  $numfuncs++;
  $numcovd++ if $calls{$bi}>0;
  $totcalls+=$calls{$bi};
}
print (('-'x51)."\n");
printf "%-30s %20lu\n",'TOTAL',$totcalls;
printf "%-30s %20s\n",'Coverage',
  sprintf('%d/%d (%.02f%%)',$numcovd,$numfuncs,
          100.0*$numcovd/($numfuncs>0?$numfuncs:0));
print (('='x51)."\n");
