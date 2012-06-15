#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Cookbook;

BEGIN {
	*CORE::GLOBAL::rand = sub (;$) { 1 }; # who needs srand() anyway
}

is( rand(100), 1, "rand ain't" );
srand(100);
is( rand(100), 1, "it really ain't" );

{
	use resub 'CORE::GLOBAL::die', sub { warn "ack!: @_\n" };
	like( stderr_of { die( 'hello world' ) }, qr/ack.*hello world/, 'downgraded exception gracefully' );
}
