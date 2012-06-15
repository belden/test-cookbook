package resub;

use strict;
use warnings;

use Test::Resub qw(resub);

my @resubs;
sub import {
	my ($class, @args) = @_;
	while (my ($target, $replacement) = splice @args, 0, 2) {
		push @resubs, resub($target, $replacement, create => 1);
	}
}

1;
