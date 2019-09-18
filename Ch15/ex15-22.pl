	my $sth = $dbh->prepare('call department_list()') || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	while ( my @row = $sth->fetchrow_array ) {
		print join("\t",@row),"\n";
	}
	$sth->finish;
