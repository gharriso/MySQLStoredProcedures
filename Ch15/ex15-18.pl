	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;

	# Print a title row
	print join("\t",@{$sth->{NAME}}),"\n";

	# Print out the values
	while ( my @row = $sth->fetchrow_array ) {
		print join("\t",@row),"\n";
	}
	$sth->finish;
