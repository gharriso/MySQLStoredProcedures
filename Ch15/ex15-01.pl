use Strict; 
use DBI;
my $dbh = DBI->connect( "DBI:mysql:prod:localhost:3306", "root", "secret" );
