	my $sql =
	  "SELECT customer_id,customer_name FROM customers WHERE sales_rep_id=1";
	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	while ( my $hash_ref = $sth->fetchrow_hashref ) {
		print $hash_ref->{customer_id}   . "\t" .
		      $hash_ref->{customer_name} . "\n";
	}
	$sth->finish;
