######
##
## Copyright (c) PerlCraft.net, 2013
## The contents of this file are the property of PerlCraft.net or its
## associate companies or organizations (the Owners), and constitute
## copyrighted proprietary software and/or information.  This file or the
## information contained therein may not be used except in compliance
## with the terms set forth hereunder.
##
## Reproduction or distribution of this file or of the information
## contained therein in any form or through any mechanism whatsoever,
## whether electronic or otherwise, is prohibited except for lawful use
## within the organization by authorized employees of the Owners
##  for the purpose of software development or operational deployment
## on authorized equipment.  Removal of this file or its contents by any
## means whether electronic or physical save when expressly permitted in
## writing by the Owners or their authorized representatives is prohibited.
##
## Installation or copying of this file or of the code contained therein on
## any equipment excepting that owned or expressly authorized for the purpose
## by the Owners is prohibited.
##
## Any violation of the terms of this licence shall be deemed to be a
## violation of the Owner's intellectual property rights and shall be
## treated as such under the applicable laws and statutes.
##
######

=head1 AUTHOR

Kanu Patel, India
Email : patelkanuv@gmail.com

=cut

package OpenTextSearch::Model::DataTransaction;

use Moose;
use Try::Tiny;
use Data::Dumper;
use Date::Calc qw(Today);
use namespace::autoclean;

extends 'Catalyst::Model';

=head1 NAME

OpenTextSearch::Model::DataTransaction - Catalyst Model

=head1 DESCRIPTION

Catalyst Model for data retrieval from various sources like database or Cache.

=cut

=head2 add_access_record

add_access_record will add record into database for web users.

=cut

sub add_access_record {
    my($self, $c)   = @_;
    
    my $access_rs   = $c->model('OpenTextSearchDB::NlpAccessStat');
    my $env         = $c->request->env;
    my $new_rec     = $access_rs->create({
        "client_ip"     => $env->{ 'REMOTE_ADDR'},
        "request_ip"    => $c->req->body_params->{ 'ip' } || $env->{ 'REMOTE_ADDR'},
        "client_name"   => 'Web Users', #TODO
        "request_string"=> $c->req->body_params->{ 'search_text' },
    });
    
    return $new_rec->id;
}

=head2 add_client_search_stats

add_client_search_stats will add record into database for JSON API users.

=cut

sub add_client_search_stats {
    my($self, $c)   = @_;
    
    my $env         = $c->request->env;
    my $client_name = $self->get_client_name($c, $c->req->body_params->{ 'client_key' });
    my $access_rs   = $c->model('OpenTextSearchDB::NlpAccessStat');
    my $new_rec     = $access_rs->create({
        "client_ip"     => $env->{ 'REMOTE_ADDR'},
        "request_ip"    => $c->req->body_params->{ 'ip' },
        "client_name"   => $client_name, 
        "request_string"=> $c->req->body_params->{ 'search_text' },
    });
    
    return $new_rec->id;
}

=head2 update_access_record

update_access_record will update record into database with status of query parsing.

=cut

sub update_access_record {
    my($self, $c, $id, $result)   = @_;
    
    my $access_rs   = $c->model('OpenTextSearchDB::NlpAccessStat');
    
    my $rows1 = $access_rs->search({ id => $id });
    $rows1->update(
        { result_status => $result}
    );
    
    return;
}

=head2 is_it_blocked_ip

is_it_blocked_ip will check for the IP is in the blocked IP range.

=cut

sub is_it_blocked_ip {
    my($self, $c, $ip)   = @_;
    
    my $num         = $self->ip_to_decimal($ip);
    my $block_ip_rs = $c->model('OpenTextSearchDB::NlpAccessBlock');
    my @rec         = $block_ip_rs->search({
        "ip_start_decimal"  => { '<=' => $num },
        "ip_end_decimal"    => { '>=' => $num },
        "active"            => 'true',
    })->all;
    
    return 1 if(scalar(@rec));
    return 0;
}

=head2 get_access_count_from_db

get_access_count_from_db returns todays access count for client.

=cut

sub get_access_count_from_db {
    my($self, $c, $ip, $client_name)   = @_;
    
    my $block_ip_rs = $c->model('OpenTextSearchDB::NlpAccessStat');
    my $count   = 0;
    $count      = $block_ip_rs->search({
        "client_ip"     => $ip,
        "client_name"   => $client_name,
        "date(access_time)" => sprintf("%04d/%02d/%02d", Today),
    })->count;
    
    return $count;
}

=head2 get_client_access_count_from_db

get_client_access_count_from_db returns todays access count for JSON client.

=cut

sub get_client_access_count_from_db {
    my($self, $c, $client_name)   = @_;
    
    my $block_ip_rs = $c->model('OpenTextSearchDB::NlpAccessStat');
    my $count   = 0;
    $count      = $block_ip_rs->search({
        "client_name"   => $client_name,
        "date(access_time)" => sprintf("%04d/%02d/%02d", Today),
    })->count;
    
    return $count;
}

=head2 get_client_name

get_client_name returns client name for the given client key.

=cut

sub get_client_name {
    my($self, $c, $client_code)   = @_;

    my $name    = $c->{ 'cache' }->read_cache('ClientAccessData_name_'.$client_code);
    if($name) {
        return $name;
    }
    
    my $block_ip_rs = $c->model('OpenTextSearchDB::ClientAccessData');
    my @rec         = $block_ip_rs->search({
        "client_key"=> $client_code,
    })->all;
    
    
    try {
        $name   = $rec[0]->client_name;
        $c->{ 'cache' }->store_cache('ClientAccessData_name_'.$client_code, $name);
    };
    
    return $name;
}

=head2 get_client_data

get_client_data returns client whole info for the given client key.

=cut

sub get_client_data {
    my($self, $c, $client_code)   = @_;

    my $name    = $c->{ 'cache' }->read_cache('ClientAccessData_data_'.$client_code);
    if($name) {
        return $name;
    }
    
    my $block_ip_rs = $c->model('OpenTextSearchDB::ClientAccessData');
    my @rec         = $block_ip_rs->search({
        "client_key"=> $client_code,
    })->all;
    
    try {
        $name   = $rec[0];
        $c->{ 'cache' }->store_cache('ClientAccessData_data_'.$client_code, $name);
    };
    
    return $name;
}

=head2 get_alloted_access

get_alloted_access returns client alleted daily access info for the given client name.

=cut

sub get_alloted_access {
    my($self, $c, $client_name)   = @_;

    my $quota    = $c->{ 'cache' }->read_cache('ClientAccessData_quota_'.$client_name);
    if($quota) {
        return $quota;
    }
    
    my $block_ip_rs = $c->model('OpenTextSearchDB::ClientAccessData');
    my @rec         = $block_ip_rs->search({
        "client_name"   => $client_name,
    })->all;
    
    $quota  = 0;
    try {
        $quota  = $rec[0]->client_quota;
        $c->{ 'cache' }->store_cache('ClientAccessData_data_'.$client_name, $quota);
    };
    
    return $quota;
}

=head2 ip_to_decimal

ip_to_decimal returns decimal equivalent of IP.

=cut

sub ip_to_decimal {
    my ($self, $ip) = @_;
    
    return unpack N => pack CCCC => split /\./x => $ip;
}

__PACKAGE__->meta->make_immutable;

1;

=head1 LICENSE

This library is private software. You can not redistribute it and/or modify. Its a property of PerlCraft.net

=cut