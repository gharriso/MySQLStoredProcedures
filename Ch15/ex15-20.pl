my $sql = 'call simple_stored_proc()';

$dbh->do($sql)||die $DBI::errstr;
