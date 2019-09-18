	my $sth = $dbh->prepare("CALL sp_rep_report(?)") || die $DBI::errstr;
	$sth->execute($sales_rep_id) || die $DBI::errstr;

	# first result set: employee_id,surname,firstname
	print 'Employee_id' . "\t" . 'Surname' . "\t" . 'Firstname' . "\n";
	while ( my $row = $sth->fetchrow_hashref ) {
		print $row->{employee_id} . "\t" . 
		      $row->{surname}     . "\t" .
		      $row->{firstname}   . "\n";
	}

	$sth->more_results;

	# second result set: customer_id,customer_name
	print 'Customer_id' . "\t" . 'Customer Name' . "\n";
	while ( my $row = $sth->fetchrow_hashref ) {
		print $row->{customer_id} . "\t" . $row->{customer_name} . "\n";
	}
	$sth->finish;
