package OpenTextSearch::Schema::OpenTextSearchDB::Result::Geoipblock;

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

OpenTextSearch::Schema::OpenTextSearchDB::Result::Geoipblock

=cut

__PACKAGE__->table("geoipblocks");

=head1 ACCESSORS

=head2 endipnum

  data_type: 'numeric'
  is_nullable: 1

=head2 location_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 startipnum

  data_type: 'numeric'
  is_nullable: 1

=head2 airport_code

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'geoipblocks_id_seq'

=cut

__PACKAGE__->add_columns(
  "endipnum",
  { data_type => "numeric", is_nullable => 1 },
  "location_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "startipnum",
  { data_type => "numeric", is_nullable => 1 },
  "airport_code",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "geoipblocks_id_seq",
  },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 location

Type: belongs_to

Related object: L<OpenTextSearch::Schema::OpenTextSearchDB::Result::Geoiplocation>

=cut

__PACKAGE__->belongs_to(
  "location",
  "OpenTextSearch::Schema::OpenTextSearchDB::Result::Geoiplocation",
  { location_id => "location_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-21 08:14:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hfYnl0K1MUHJEXxKTNd+Pw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
