package String::Numeric::PP;
use strict;
use warnings;

use Carp                    qw[croak];
use String::Numeric::Regexp qw[:all];

BEGIN {
    our $VERSION   = '0.9_01';
    our @EXPORT_OK = qw(
      is_numeric
      is_float
      is_decimal
      is_integer
      is_int
      is_int8
      is_int16
      is_int32
      is_int64
      is_int128
      is_uint
      is_uint8
      is_uint16
      is_uint32
      is_uint64
      is_uint128
    );

    require Exporter;
    *import = \&Exporter::import;
}

sub INT128_MIN  () { '170141183460469231731687303715884105728' }
sub INT128_MAX  () { '170141183460469231731687303715884105727' }
sub UINT128_MAX () { '340282366920938463463374607431768211455' }

*is_numeric = \&is_float;
*is_integer = \&is_int;

sub is_float {
    @_ == 1 || croak(q/Usage: is_float(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$Float_re\z/o );
}

sub is_decimal {
    @_ == 1 || croak(q/Usage: is_decimal(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$Decimal_re\z/o );
}

sub is_int {
    @_ == 1 || croak(q/Usage: is_int(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$Int_re\z/o );
}

sub is_int8 {
    @_ == 1 || croak(q/Usage: is_int8(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$Int8_re\z/o );
}

sub is_int16 {
    @_ == 1 || croak(q/Usage: is_int16(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$Int16_re\z/o );
}

sub is_int32 {
    @_ == 1 || croak(q/Usage: is_int32(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$Int32_re\z/o );
}

sub is_int64 {
    @_ == 1 || croak(q/Usage: is_int64(string)/);
    local $_ = $_[0];
    return ( defined $_[0] && $_[0] =~ /\A$Int64_re\z/o );
}

sub is_int128 {
    @_ == 1 || croak(q/Usage: is_int128(string)/);
    local $_ = $_[0];
    return ( defined
          && /\A(-?)(0|[1-9][0-9]{0,38})\z/
          && ( length $2 < 39 || ( $1 ? $2 le INT128_MIN : $2 le INT128_MAX ) ) );
}

sub is_uint {
    @_ == 1 || croak(q/Usage: is_uint(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$UInt_re\z/o );
}

sub is_uint8 {
    @_ == 1 || croak(q/Usage: is_uint8(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$UInt8_re\z/o );
}

sub is_uint16 {
    @_ == 1 || croak(q/Usage: is_uint16(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$UInt16_re\z/o );
}

sub is_uint32 {
    @_ == 1 || croak(q/Usage: is_uint32(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$UInt32_re\z/o );
}

sub is_uint64 {
    @_ == 1 || croak(q/Usage: is_uint64(string)/);
    return ( defined $_[0] && $_[0] =~ /\A$UInt64_re\z/o );
}

sub is_uint128 {
    @_ == 1 || croak(q/Usage: is_uint128(string)/);
    local $_ = $_[0];
    return ( defined
          && /\A(0|[1-9][0-9]{0,38})\z/
          && ( length $1 < 39 || $1 le UINT128_MAX ) );
}

1;

