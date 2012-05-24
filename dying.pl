#!/usr/bin/env perl

use strict;
use warnings;

use Want qw(rreturn);
use Test::Resub qw(resub);
BEGIN { *CORE::GLOBAL::die = sub { CORE::die(@_) } }

use Data::Dumper;

{
  my @died;
  sub died { return wantarray ? @died : scalar @died }
  sub died_with { push @died, [@_] }
}

sub do_something_that_might_die {
  die "toy example always dies";
}

{
  my $rs_die = resub 'CORE::GLOBAL::die', sub { died_with(@_); rreturn undef };

  my $out = do_something_that_might_die();
  if (!defined $out && died) {
    print "looks like we caught a die: " . Dumper(died);
  }
}

do_something_that_might_die;
die "I don't believe we got here";
