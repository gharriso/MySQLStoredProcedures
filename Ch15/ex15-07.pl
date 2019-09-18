my $sth=$dbh->prepare('INSERT INTO bind_example(col1,col2) VALUES(?,?)')
	||die $DBI::errstr;
for (my $i=1; $i<=10;$i++) {
	$sth->bind_param(1,$i);
	$sth->bind_param(2,'Row# '||$i);
	$sth->execute||die $DBI::errstr;
}
$sth->finish;
