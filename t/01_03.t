#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Scalar::Util qw(refaddr);

{
	package Dispatched::Subclass;

	sub dispatch_table {
		my ($class) = @_;
		return (
			add => $class->can('do_add'),
			get => \&do_get,
			delete => \&do_delete,
		 );
	}

	sub do_add { die "gotcha!\n"; 1 }
	sub do_get { 2 }
	sub do_delete { 3 }
}

my %dispatch_table = Dispatched::Subclass->dispatch_table;

sub coderefs_same ($$;$) {
	my ($g1, $g2, $message) = @_;
	my ($class, $method) = $g2 =~ m{^(.*)::(.*?)$};
	$g2 = $class->can($method);
	is( $g1, $g2, $message );
}

# repeat for every other entry in %dispatch_table
# is( $dispatch_table{add}, \&Dispatched::Subclass::add, 'add is the right \&add' );
# is( refaddr($dispatch_table{add}), refaddr(\&Dispatched::Subclass::add), 'add really is add' );

coderefs_same( $dispatch_table{add}, 'Dispatched::Subclass::do_add', 'add is the right add' );
