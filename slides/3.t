#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Cookbook;

my @expected = (1, 2, 3, 5, 8, 13, 21);

{
	my $fib = 0;
	sub fibonacci { $fib++; $fib += 7 if $fib > 5; $fib }
	sub fib_reset { $fib = 0 }
}

fib_reset;
foreach (@expected) {
	is( fibonacci(), $_ );
}

fib_reset;
my @bad;
foreach (@expected) {
	push @bad, $_ unless fibonacci() == $_;
}
deep_ok( \@bad, [] );

fib_reset();
each_ok { fibonacci(), $_ } @expected;
