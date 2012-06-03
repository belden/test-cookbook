package Test::Cookbook;

use strict;
use warnings;

use base qw(Exporter);

# I like all my testing functions to end in _ok. Here's one thing that lets me do.
our @EXPORT = qw(deep_ok xml_ok html_ok);

use XML::Simple ();
use Test::Differences ();

sub deep_ok ($$;$) {
	Test::Differences::unified_diff;
	Test::Differences::eq_or_diff(@_);
}

sub xml_ok ($$;$) {
	my ($got, $expected, $message) = @_;

	my $convert_to_data = sub {
		my ($xml) = @_;
		return XML::Simple::XMLin($xml, ForceArray => 1);
	};

	return deep_ok( $convert_to_data->($got), $convert_to_data->($expected), $message );
}

1;
