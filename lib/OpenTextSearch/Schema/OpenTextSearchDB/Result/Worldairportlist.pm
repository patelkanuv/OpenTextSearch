package OpenTextSearch::Schema::OpenTextSearchDB::Result::Worldairportlist;

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

OpenTextSearch::Schema::OpenTextSearchDB::Result::Worldairportlist

=cut

__PACKAGE__->table("worldairportlist");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'worldairportlist_id_seq'

=head2 city_name

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 country_name

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 country_code

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 airport_name

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 airport_code

  data_type: 'varchar'
  is_nullable: 1
  size: 4

=head2 prov_name

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 prov_code

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 longitude

  data_type: 'double precision'
  is_nullable: 1

=head2 latitude

  data_type: 'double precision'
  is_nullable: 1

=head2 operating

  data_type: 'boolean'
  default_value: true
  is_nullable: 1

=head2 capital_city

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "worldairportlist_id_seq",
  },
  "city_name",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "country_name",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "country_code",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "airport_name",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "airport_code",
  { data_type => "varchar", is_nullable => 1, size => 4 },
  "prov_name",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "prov_code",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "longitude",
  { data_type => "double precision", is_nullable => 1 },
  "latitude",
  { data_type => "double precision", is_nullable => 1 },
  "operating",
  { data_type => "boolean", default_value => \"true", is_nullable => 1 },
  "capital_city",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-21 08:14:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BpFU3wzO8j78mb2GCAY2EA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
