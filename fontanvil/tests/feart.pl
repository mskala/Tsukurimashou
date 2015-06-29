#!/usr/bin/perl

exit 77 if !-r 'ttmp/tsuku-kg3.fea';

print "Checking feature file round-trip results from feamerge.pe.\n";

$/=undef;

open(IN,'../fea/tsuku.fea');
$pass0=<IN>;
close(IN);
open(IN,'../fea/monospace.fea');
$pass0.=<IN>;
close(IN);

open(IN,'ttmp/tsuku-kg1.fea');
$pass1=<IN>;
close(IN);

open(IN,'ttmp/tsuku-kg2.fea');
$pass2=<IN>;
close(IN);

open(IN,'ttmp/tsuku-kg3.fea');
$pass3=<IN>;
close(IN);

$pass0=~s/#.*\n//g;

$is_error=0;
while ($pass3=~/[ \\]([a-zA-Z0-9]{4})[ ;]/g) {
  $have_tags{$1}=1;
}
while ($pass0=~/ ([a-zA-Z0-9]{4})[ ;]/g) {
  if (!$have_tags{$1}) {
    print "Four-letter word $1 is present in input and not output.\n";
    $have_tags{$1}=1;
    $is_error=1;
  }
}

if (($pass1 eq $pass2) && ($pass2 eq $pass3)) {
  print "Round trips are consistently idempotent.\n";
  exit($is_error);
}

if (($pass1 ne $pass2) && ($pass2 eq $pass3)) {
  print "First round trip is not idempotent, but second is.\n";
  exit($is_error);
}

if (($pass1 eq $pass2) && ($pass2 ne $pass3)) {
  print "First round trip is idempotent, but second is not (BAD NEWS!)\n";
  exit(1);
}

if (($pass1 ne $pass2) && ($pass1 eq $pass3)) {
  print "Round trips appear to be self-inverse (strange, but okay).\n";
  exit($is_error);
}

print "Round-trips do not produce consistent results.\n";
exit(1);
