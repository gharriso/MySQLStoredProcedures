my $dbh = DBI->connect( "DBI:mysql:prod:localhost:3306",
	"root", "secret", { AutoCommit => 0, PrintError => 0, RaiseError => 0 } )
  || die "Connection error: ".$DBI::errstr;
