#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

{
	package some;
	sub where { 'beyond the sea' }
}

is( some->where, 'beyond the sea', 'default value' );

{
	no warnings 'redefine';
	local *some::where = sub { 'over the rainbow' };
	is( some->where, 'over the rainbow', 'ook ook ook!' );
}

is( some->where, 'beyond the sea', 'back to normal' );
