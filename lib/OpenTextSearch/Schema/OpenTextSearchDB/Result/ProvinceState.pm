package OpenTextSearch::Schema::OpenTextSearchDB::Result::ProvinceState;

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

OpenTextSearch::Schema::OpenTextSearchDB::Result::ProvinceState

=cut

__PACKAGE__->table("province_state");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'province_state_id_seq'

=head2 code

  data_type: 'varchar'
  is_nullable: 1
  size: 60

=head2 prov_name

  data_type: 'varchar'
  is_nullable: 1
  size: 60

=head2 country_name

  data_type: 'varchar'
  is_nullable: 1
  size: 60

=head2 country_code

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 major_airport

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "province_state_id_seq",
  },
  "code",
  { data_type => "varchar", is_nullable => 1, size => 60 },
  "prov_name",
  { data_type => "varchar", is_nullable => 1, size => 60 },
  "country_name",
  { data_type => "varchar", is_nullable => 1, size => 60 },
  "country_code",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "major_airport",
  { data_type => "varchar", is_nullable => 1, size => 3 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-21 08:14:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OhyTc0HLIacp06ibTtkBOg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
