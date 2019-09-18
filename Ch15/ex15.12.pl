	my $sql =
	  "SELECT customer_id,customer_name FROM customers WHERE sales_rep_id=1";
	my $sth = $dbh->prepare($sql) || die $DBI::errstr;
	$sth->execute || die $DBI::errstr;
	my $table = $sth->fetchall_arrayref||die $DBI::errstr; 
	for my $i ( 0 .. $#{$table} ) {
		for my $j ( 0 .. $#{ $table->[$i] } ) {
			print "$table->[$i][$j]\t";
		}
		print "\n";
	}
