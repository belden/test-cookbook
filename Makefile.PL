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
		Capture::Tiny
		Devel::LexAlias
		File::Temp
		IO::Capture
		Memoize
		Signals::XSIG
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
		Test::XML
		WWW::Selenium
		XML::Parser
		XML::Simple
		XML::Twig
	)},
	PL_FILES            => {},
	dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);
