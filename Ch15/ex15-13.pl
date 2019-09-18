	my $sql =
	  "SELECT customer_id,customer_name FROM customers WHERE sales_rep_id=1";
	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	my $table = $sth->fetchall_arrayref({}) || die $DBI::errstr;
	foreach my $row (@$table) {
		print $row->{customer_id} . "\t" . $row->{customer_name} . "\n";
	}
