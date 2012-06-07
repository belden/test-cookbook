package Test::Cookbook;

use strict;
use warnings;

use base qw(Exporter);

our @EXPORT = qw(
  deep_ok
  set_ok
  system_ok
  memoized_ok
  xml_ok
  stdout_of
  stderr_of
	each_ok
);

use XML::Simple ();
use Test::Differences ();
use IO::Capture::Stderr ();
use IO::Capture::Stdout ();

use mock_object;

sub deep_ok ($$;$) {
	local $Test::Builder::Level = $Test::Builder::Level + 1;
	Test::Differences::unified_diff;
	Test::Differences::eq_or_diff(@_);
}

sub set_ok ($$;$) {
	$_ = [sort @$_] foreach grep { ref($_) eq 'ARRAY' } @_;
	goto &deep_ok;
}

sub system_ok ($$;$) {
	my ($command, $message) = @_;
	my $exit = CORE::system($command);
	Test::More::is( $exit, 0, $message );
}

sub memoized_ok ($;$) {
	my ($function, $message) = @_;
	local $@;
	eval "require Memoize; Memoize::unmemoize('$function')";
	my $err = $@;
	Test::More::ok( $err eq '', $message );
}

sub xml_ok ($$;$) {
	my ($got, $expected, $message) = @_;

	my $convert_to_data = sub {
		my ($xml) = @_;
		return XML::Simple::XMLin($xml, ForceArray => 1);
	};

	return deep_ok( $convert_to_data->($got), $convert_to_data->($expected), $message );
}

# Capture::Tiny
sub stdout_of(&) { return _captured('IO::Capture::Stdout', @_) }
sub stderr_of(&) { return _captured('IO::Capture::Stderr', @_) }

sub _captured {
	my ($capture_class, $code) = @_;
	my $capture = $capture_class->new;
	$capture->start;
	$code->();
	$capture->stop;
	return join '', $capture->read;
}

sub each_ok (&@) {
	my $code = shift;

	my (@got, @expected);
	local $_;

	my @bad;
	my $index = 0;
	foreach (@_) {
		my $raw = $_;
		my @out = $code->();

		if (@out == 1) {
			if (! $out[0]) {
				push @bad, +{
					raw => $raw,
					got => $out[0],
					expected => 'something true',
					-index => $index,
				};
			}
		} elsif (@out == 2) {
			if ($out[0] ne $out[1]) {
				push @bad, +{
					raw => $raw,
					got => $out[0],
					expected => $out[1],
					-index => $index,
				};
			}
		}
		$index++;
	}

	deep_ok( \@bad, [] );
}

1;
