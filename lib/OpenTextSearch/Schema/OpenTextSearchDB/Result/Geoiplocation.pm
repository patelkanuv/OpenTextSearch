package OpenTextSearch::Schema::OpenTextSearchDB::Result::Geoiplocation;

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

OpenTextSearch::Schema::OpenTextSearchDB::Result::Geoiplocation

=cut

__PACKAGE__->table("geoiplocation");

=head1 ACCESSORS

=head2 areacode

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 city

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 country

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 latitude

  data_type: 'numeric'
  is_nullable: 1

=head2 location_id

  data_type: 'integer'
  is_nullable: 0

=head2 longitude

  data_type: 'numeric'
  is_nullable: 1

=head2 metrocode

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 postalcode

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 region

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "areacode",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "city",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "country",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "latitude",
  { data_type => "numeric", is_nullable => 1 },
  "location_id",
  { data_type => "integer", is_nullable => 0 },
  "longitude",
  { data_type => "numeric", is_nullable => 1 },
  "metrocode",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "postalcode",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "region",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("location_id");

=head1 RELATIONS

=head2 geoipblocks

Type: has_many

Related object: L<OpenTextSearch::Schema::OpenTextSearchDB::Result::Geoipblock>

=cut

__PACKAGE__->has_many(
  "geoipblocks",
  "OpenTextSearch::Schema::OpenTextSearchDB::Result::Geoipblock",
  { "foreign.location_id" => "self.location_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-21 08:14:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KLeGCJFrhFx/UzDM0l8Q3A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
