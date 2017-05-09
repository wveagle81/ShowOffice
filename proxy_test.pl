#! /usr/bin/perl
use strict;
use warnings;
use HTTP::Proxy;
use CGI;

my $proxy = HTTP::Proxy->new(host => "localhost");
$proxy->logmask(32); # 32 - FILTERS
$proxy->push_filter(
        request => Spy::BodyFilter->new(),
);
$proxy->start;

package Spy::BodyFilter;
use base qw(HTTP::Proxy::BodyFilter);

sub will_modify { 0 }

sub filter
{
    my ($me, undef, $req) = @_;
    print $req->method, " ", $req->uri, "\n";
    return unless $req->method eq "POST";
    my $body = $req->content;
    my $q = new CGI($body);
    for my $p ($q->param) {
        next if $p eq "__VIEWSTATE";
        print "$p\n\t", $q->param($p), "\n";
    }
}
