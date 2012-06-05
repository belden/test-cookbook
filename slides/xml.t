#!/usr/bin/env perl

use strict;
use warnings;

use Test::XML;
use Test::More;

use lib '../lib';
use Test::Cookbook;

my $expected = <<XML;
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <SOAP-ENV:Envelope
      SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"
      xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\"
      xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\"
      xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"
      xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">
      <SOAP-ENV:Body>
        <checkVat xmlns=\"urn:ec.europa.eu:taxud:vies:services:checkVat:types\">
          <countryCode>DE</countryCode>
          <vatNumber>123</vatNumber>
        </checkVat>
      </SOAP-ENV:Body>
    </SOAP-ENV:Envelope>
XML

my $got = $expected;
is_xml( $got, $expected, 'built it good' );

# provoke a deliberate failure: vatNumber -> cat_Number
($got = $expected) =~ s{<vatNumber>123</vatNumber>}{<cat_Number>456</cat_Number>};
is_xml( $got, $expected, 'miaowed it good' );
xml_ok( $got, $expected, 'purr' );

my $html_expected = <<HTML;
<html>
<head><title>hi mom</title></head>
<body><p />hello world</body>
</html>
HTML

(my $html_got = $html_expected) =~ s{hello}{goodbye};
is_xml( $html_got, $html_expected );
xml_ok( $html_got, $html_expected );
