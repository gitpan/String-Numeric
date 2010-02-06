package String::Numeric::Regexp;
use strict;
use warnings;

BEGIN {
    our $VERSION   = '0.9_01';
    our @EXPORT_OK = qw(
        $Float_re
        $Decimal_re
        $Numeric_re
        $Int_re
        $Int8_re
        $Int16_re
        $Int32_re
        $Int64_re
        $UInt_re
        $UInt8_re
        $UInt16_re
        $UInt32_re
        $UInt64_re
    );

    our %EXPORT_TAGS = ( 
        all  => [ @EXPORT_OK ], 
        int  => [ grep { /^\$Int/ }  @EXPORT_OK ],
        uint => [ grep { /^\$UInt/ } @EXPORT_OK ],
    );

    require Exporter;
    *import = \&Exporter::import;
}

our $Float_re   = qr<-?(?:0|[1-9][0-9]*)(?:\.[0-9]+)?(?:[eE][+-]?[0-9]+)?>;
our $Decimal_re = qr<-?(?:0|[1-9][0-9]*)(?:\.[0-9]+)?>;
our $Numeric_re = $Float_re;

our $UInt_re = qr<0|[1-9][0-9]*>;

# 0 to 127
our $UInt7_re = qr<
       0
  | [1-9][0-9]{0,1}
  |    1 (?:   [0-1][0-9]
  |        | 2 [0-7])
>x;

# 0 to 255
our $UInt8_re = qr<
       0
  |    1 [0-9]{0,2}
  | [2-9][0-9]{0,1}
  |    2 (?:   [0-4][0-9]
           | 5 [0-5])
>x;

# 0 to 32,767
our $UInt15_re = qr<
       0
  | [1-2][0-9]{0,4}
  | [3-9][0-9]{0,3}
  |    3 (?:       [0-1][0-9]{3}
           | 2 (?: [0-6][0-9]{2}
           | 7 (?: [0-5][0-9]
           | 6 [0-7])))
>x;

# 0 to 65,535
our $UInt16_re = qr<
       0
  | [1-5][0-9]{0,4}
  | [6-9][0-9]{0,3}
  |    6 (?:       [0-4][0-9]{3}
           | 5 (?: [0-4][0-9]{2}
           | 5 (?: [0-2][0-9]
           | 3 [0-5])))
>x;

# 0 to 2,147,483,647
our $UInt31_re = qr<
       0
  |    1 [0-9]{0,9}
  | [2-9][0-9]{0,8}
  |    2 (?: 0          [0-9]{8}
           | 1 (?: [0-3][0-9]{7}
           | 4 (?: [0-6][0-9]{6}
           | 7 (?: [0-3][0-9]{5}
           | 4 (?: [0-7][0-9]{4}
           | 8 (?: [0-2][0-9]{3}
           | 3 (?: [0-5][0-9]{2}
           | 6 (?: [0-3][0-9]
           | 4 [0-7]))))))))
>x;

# 0 to 4,294,967,295
our $UInt32_re = qr<
       0
  | [1-3][0-9]{0,9}
  | [4-9][0-9]{0,8}
  |    4 (?:       [0-1][0-9]{8}
           | 2 (?: [0-8][0-9]{7}
           | 9 (?: [0-3][0-9]{6}
           | 4 (?: [0-8][0-9]{5}
           | 9 (?: [0-5][0-9]{4}
           | 6 (?: [0-6][0-9]{3}
           | 7 (?: [0-1][0-9]{2}
           | 2 (?: [0-8][0-9]
           | 9 [0-5]))))))))
>x;

# 0 to 9,223,372,036,854,775,807
our $UInt63_re = qr<
       0
  | [1-8][0-9]{0,18}
  |    9 [0-9]{0,17}
  |    9 (?:        [0-1][0-9]{17}
           | 2  (?: [0-1][0-9]{16}
           | 2  (?: [0-2][0-9]{15}
           | 3  (?: [0-2][0-9]{14}
           | 3  (?: [0-6][0-9]{13}
           | 7  (?: [0-1][0-9]{12}
           | 20 (?: [0-2][0-9]{10}
           | 3  (?: [0-5][0-9]{9}
           | 6  (?: [0-7][0-9]{8}
           | 8  (?: [0-4][0-9]{7}
           | 5  (?: [0-3][0-9]{6}
           | 4  (?: [0-6][0-9]{5}
           | 7  (?: [0-6][0-9]{4}
           | 7  (?: [0-4][0-9]{3}
           | 5  (?: [0-7][0-9]{2}
           | 80 [0-7])))))))))))))))
>x;

# 0 to 18,446,744,073,709,551,615
our $UInt64_re = qr<
       0
  | [1-9][0-9]{0,18}
  |    1 (?:        [0-7][0-9]{18}
           | 8  (?: [0-3][0-9]{17}
           | 4  (?: [0-3][0-9]{16}
           | 4  (?: [0-5][0-9]{15}
           | 6  (?: [0-6][0-9]{14}
           | 7  (?: [0-3][0-9]{13}
           | 4  (?: [0-3][0-9]{12}
           | 40 (?: [0-6][0-9]{10}
           | 7  (?: [0-2][0-9]{9}
           | 3  (?: [0-6][0-9]{8}
           | 70 (?: [0-8][0-9]{6}
           | 9  (?: [0-4][0-9]{5}
           | 5  (?: [0-4][0-9]{4}
           | 5  (?:    0 [0-9]{3}
           | 1  (?: [0-5][0-9]{2}
           | 6  (?:    0 [0-9]
           | 1 [0-5]))))))))))))))))
>x;

our $Int_re = qr<-?(?:0|[1-9][0-9]*)>;

# −128 to 127
our $Int8_re = qr<(?: - (?: $UInt7_re | 128 )) | $UInt7_re>x;

# −32,768 to 32,767
our $Int16_re = qr<(?: - (?: $UInt15_re | 32768 )) | $UInt15_re>x;

# −2,147,483,648 to 2,147,483,647
our $Int32_re = qr<(?: - (?: $UInt31_re | 2147483648 )) | $UInt31_re>x;

# −9,223,372,036,854,775,808 to +9,223,372,036,854,775,807
our $Int64_re = qr<(?: - (?: $UInt63_re | 9223372036854775808 )) | $UInt63_re>x;

1;

__END__

=head1 NAME

String::Numeric::Regexp - Regular expressions for matching numeric values

=head1 SYNOPSIS

    if (/\A$UInt32\z/o) {
        print "ok"
    }

=head1 DESCRIPTION

Provides regexps to match numeric values. These are used internally by
C<String::Numeric::PP>. Please see L<String::Numeric> for expected matches.

=head1 REGEXPS

=head2 C<$Float_re>

=head2 C<$Decimal_re>

=head2 C<$Numeric_re>

Alias to C<$Float_re>.

=head2 C<$Int_re>

=head2 C<$Int8_re>

=head2 C<$Int16_re>

=head2 C<$Int32_re>

=head2 C<$Int64_re>

=head2 C<$UInt_re>

=head2 C<$UInt8_re>

=head2 C<$UInt16_re>

=head2 C<$UInt32_re>

=head2 C<$UInt64_re>

=head1 EXPORTS

None by default. Regexps can either be imported individually or
in sets grouped by tag names. The tag names are:

=over 4

=item C<:all> exports all regexps.

=item C<:int> exports all C<$Int> regexps.

=item C<:uint> exports all C<$UInt> regexps.

=back

=head1 SEE ALSO

L<String::Numeric>

L<Regexp::Common::number>

=head1 AUTHOR

Christian Hansen C<chansen@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2009-2010 Christian Hansen.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
