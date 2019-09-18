	my $sth = $dbh->prepare('call customer_list(?)') || die $DBI::errstr;

	for ( my $sales_rep_id = 1 ; $sales_rep_id < 10 ; $sales_rep_id++ ) {
		print "Customers for sales rep id = " . $sales_rep_id;
		$sth->execute($sales_rep_id) || die $DBI::errstr;
		while ( my @row = $sth->fetchrow_array ) {
			print join( "\t", @row ), "\n";
		}
	}
	$sth->finish; 
