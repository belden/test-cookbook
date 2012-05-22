#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 1;

use Data::Dumper;

my @modules = qw(
  Capture::Tiny
  Devel::LexAlias
  IO::Capture
  Memoize
  Signals::XSIG
  File::Temp
  Test::Deep
  Test::Exception
  Test::Exit
  Test::MockObject
  Test::More
  Test::Output
  Test::Resub
  Test::Warn
  Test::Wiretap
  Test::WWW::Selenium
  WWW::Selenium
  XML::Parser
  XML::Simple
  XML::Twig
);

my @bad;
foreach (@modules) {
	local $@;
	eval "use $_; 1" && next;
	push @bad, [$_, $@];
}
is_deeply( \@bad, [], 'no errors' ) or warn Dumper(\@bad);
