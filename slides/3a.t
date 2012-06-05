#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Cookbook;
use Test::Differences;

use LWP::UserAgent;
use JSON::XS;

sub url_to_json {
	my ($url, %params) = @_;

	my $ua = LWP::UserAgent->new;
	my $response = $ua->get($url, %params);

	if ($response->is_success) {
		return decode_json($response->content);
	} else {
		return {};
	}
}

my $mock = mock_object->new(
	is_success => 1,
	content => '{"hello": "world"}',
);
$mock->install_at('LWP::UserAgent::new');

my $response = url_to_json('http://0:8000/foo/bar');
eq_or_diff( $response, {hello => 'madison'} );
