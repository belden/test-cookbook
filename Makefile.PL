use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME                => 'Test::Cookbook',
	AUTHOR              => q{Belden Lyman <belden@shutterstock.com>},
	VERSION             => 0.01,
	ABSTRACT            => 'Makefile.PL for my Test::Cookbook talk at YAPC::NA 2012',
	LICENSE => 'perl',
	PREREQ_PM => +{ map { ($_ => 0) } qw(
		Test::More
		IO::Capture
		Test::MockObject
		Test::Output
		Capture::Tiny
		Test::Resub
		Test::Wiretap
		Test::Deep
		XML::Simple
		XML::Twig
		XML::Parser
		Memoize
		Devel::LexAlias
		Test::WWW::Selenium
		WWW::Selenium
		File::Temp
		Signals::XSIG
		Test::Exit
		Test::Warn
		Test::Exception
	)},
	PL_FILES            => {},
	dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);
