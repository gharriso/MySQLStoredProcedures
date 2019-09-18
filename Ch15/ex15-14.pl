	my $sql =
	  "SELECT customer_id,customer_name FROM customers WHERE sales_rep_id=1";
	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	my $row_count = $sth->dump_results;
	$sth->finish;
