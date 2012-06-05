#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Deep ();
use Test::Struct ();
use Test::Differences ();

my @got       = (0, [1, 2, {hello => 'madison!'}, 3, [4, 5]]);
my @expected  = (0, [2, 2, {goodnight => 'moon'}, 3, [5, 4]]);

Test::More::is_deeply( \@got, \@expected );
# Test::Deep::cmp_deeply( \@got, \@expected );
# Test::Struct::deep_eq( \@got, \@expected );
# Test::Differences::eq_or_diff( \@got, \@expected );

# Test::Differences::context_diff;
# Test::Differences::eq_or_diff( \@got, \@expected, 'eq_or_diff - context_diff' );

# Test::Differences::unified_diff;
# Test::Differences::eq_or_diff( \@got, \@expected, 'eq_or_diff - unified_diff' );

__END__
