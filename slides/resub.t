#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Test::Resub qw(resub);

{
	package some;
	sub where { 'beyond the sea' }
}

is( some->where, 'beyond the sea', 'default value' );

{
	my $rs = resub 'some::where', sub { 'over the rainbow' };
	is( some->where, 'over the rainbow', 'new code in place' );
}

is( some->where, 'beyond the sea', 'back to normal' );
