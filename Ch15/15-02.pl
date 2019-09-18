my $dbh = DBI->connect( "DBI:mysql:prod:localhost:3306",
	"root", "secret", { AutoCommit => 0, PrintError => 1, RaiseError => 0 } )
