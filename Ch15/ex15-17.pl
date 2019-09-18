	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	foreach my $colno ( 0 .. $sth->{NUM_OF_FIELDS} - 1 ) {
		print "Name= "
		  . $sth->{NAME}->[$colno]
		  . "\tType="
		  . $sth->{TYPE}->[$colno] . "\n";

	}

