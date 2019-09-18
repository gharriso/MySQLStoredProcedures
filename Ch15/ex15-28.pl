	my $sql =
	  'call sp_rep_customer_count(1,@customer_count)';   #watch out for the "@"!
	my $sth = $dbh->prepare($sql);
	$sth->execute() || die $DBI::errstr;
	$sth->finish;

	# Now get the output variable

	my @result = $dbh->selectrow_array('SELECT @customer_count')
	  || die $DBI::errstr;
	print "customer_count=", $result[0], "\n";
