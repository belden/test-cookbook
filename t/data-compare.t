#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Builder;
use Test::Struct ();
use Test::Differences qw(eq_or_diff context_diff unified_diff);

my @got       = (0, [1, 2, {hello => 'madison!'}, 3, [4, 5]]);
my @expected  = (0, [2, 2, {goodnight => 'moon'}, 3, [5, 4]]);

# context_diff;
# eq_or_diff( \@got, \@expected, 'eq_or_diff - context_diff' );

# unified_diff;
# eq_or_diff( \@got, \@expected, 'eq_or_diff - unified_diff' );

deep_ok( \@got, \@expected );

__END__
