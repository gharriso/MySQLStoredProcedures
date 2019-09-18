sub execute_procedure() {
	my ( $dbh, $stored_procedure_call ) = @_;
	my $sth = $dbh->prepare($stored_procedure_call)
	  || die $DBI::err . ": " . $DBI::errstr;
	$sth->execute || die DBI::err . ": " . $DBI::errstr;
	my $result_set_no = 0;

	do {

	 
		print "\n", ( '=' x 20 ) . " Result Set # ",
		  ++$result_set_no . ( '=' x 20 ), "\n\n";

		print join( "\t", @{ $sth->{NAME} } ),"\n", ( '-' x 54 ), "\n";

		while ( my @row = $sth->fetchrow_array() ) {
			print join( "\t", @row ), "\n";
		}
		}
	} until ( !$sth->more_results );
}
