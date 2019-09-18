	my ( $customer_id, $customer_name );
	my $sql =
	  "SELECT customer_id,customer_name FROM customers WHERE sales_rep_id=1";
	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	$sth->bind_col( 1, \$customer_id );
	$sth->bind_col( 2, \$customer_name );

	while ( $sth->fetch ) {
		print join( "\t", ( $customer_id, $customer_name ) ), "\n";
	}
