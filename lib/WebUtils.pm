package WebUtils;

use strict;
use warnings;

use base qw(Exporter);
our @EXPORT_OK = qw(url_to_json);

use JSON::XS qw(decode_json);
use LWP::UserAgent;

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

1;
