	my $sql =
	  "SELECT customer_id,customer_name FROM customers WHERE sales_rep_id=1";
	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	while ( my $row_ref = $sth->fetchrow_arrayref ) {
		print $row_ref->[0]."\t".$row_ref->[1]."\n";
	}
	$sth->finish;
