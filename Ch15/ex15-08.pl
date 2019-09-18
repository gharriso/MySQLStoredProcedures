my $sth = $dbh->prepare('INSERT INTO bind_example(col1,col2) VALUES(?,?)')
  || die $DBI::errstr;
for ( my $i = 1 ; $i <= 10 ; $i++ ) {
	my $col2_value = 'Row2#' . $i;
	$sth->execute( $i, $col2_value ) || die $DBI::errstr;
}
