my $sth=$dbh->prepare('set @myvariable=9')||die $DBI::errstr;
$sth->execute||die $DBI::errstr;
