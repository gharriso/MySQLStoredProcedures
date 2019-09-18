	my $sql =
	  "SELECT customer_id,customer_name FROM customers WHERE sales_rep_id=1";
	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	while ( my @row = $sth->fetchrow_array ) {
		print $row[0] ."\t". $row[1] . "\n";
	}
	$sth->finish;
