package OpenTextSearch::Schema::OpenTextSearchDB::Result::AirportAdditionalInfo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

OpenTextSearch::Schema::OpenTextSearchDB::Result::AirportAdditionalInfo

=cut

__PACKAGE__->table("airport_additional_info");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'airport_additional_info_id_seq'

=head2 city

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 country_code

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 airport_name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 airport_code

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=head2 country_name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 longitude

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 latitude

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 world_area_code

  data_type: 'integer'
  is_nullable: 1

=head2 runway_length

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 runway_elevation

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 email

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 telephone

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 fax

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 gmt_offset

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "airport_additional_info_id_seq",
  },
  "city",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "country_code",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "airport_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "airport_code",
  { data_type => "varchar", is_nullable => 1, size => 3 },
  "country_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "longitude",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "latitude",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "world_area_code",
  { data_type => "integer", is_nullable => 1 },
  "runway_length",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "runway_elevation",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "email",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "telephone",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "fax",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "gmt_offset",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-21 08:14:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7ljh39NwmCX1Q39wvYP6YQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
