<%once>
       use JSON::XS;
</%once>
<%args>
       $jsonp => 0
</%args>
<%perl>
    $r->content_type('application/json');

#my $results = eval { $sqldb->do_sql( $sql ) };
#my $error = $@ ? $@ : undef;

    my $data = [ {}, {}, {} ];
    my $json = encode_json( $data );
</%perl>

<% $jsonp ? "$jsonp($json)" : $json %>
