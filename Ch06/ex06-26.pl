$dbh = DBI->connect("DBI:mysql:$database:$host:$port",
		    "$user", "$password",
		  { PrintError => 0}) || die $DBI::errstr;
                  
if ($dbh->do("call error_test_proc(1)"))
{
    printf("Stored procedure execution succeeded\n");
}
else
{
    printf("Error executing stored procedure: MySQL error %d (SQLSTATE %s)\n %s\n",
             $dbh->err,$dbh->state,$dbh->errstr); 
}
