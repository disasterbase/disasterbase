package Disaster::Email;

use strict;
use warnings;

use Regexp::Common qw[Email::Address];
use Email::Address;
use Net::validMX;

######################################################################

  sub validate_email {
    my $email = shift;
    $email =~ /^$RE{Email}{Address}$/ or return;
    my ( $status, $reason, $sanitized ) = Net::validMX::check_email_and_mx( $email );
    $status or return;
    return $sanitized;
  }

######################################################################

1;
