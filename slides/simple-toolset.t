#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Cookbook;

my %h1 = my @a1 = (1 => 2, 3 => 4, 5 => 6);
my %h2 = my @a2 = (5 => 6, 1 => 2, 3 => 4);

deep_ok( \%h1, \%h2 );
deep_ok( \@a1, \@a2 );
set_ok( \@a1, \@a2 );

system_ok( '/bin/true', 'shell true is Perl true' );

{
	package something;
	require Memoize;

	sub expensive {}

	Memoize::memoize('memoized');
	sub memoized {}
}

memoized_ok( 'something::expensive', 'something::expensive is memoized' );
memoized_ok( 'something::memoized', 'something::memoized is memoized' );

is( stdout_of { print "hello world" }, 'hello world' );
is( stderr_of { warn "hello stderr\n" }, "hello stderr\n" );
