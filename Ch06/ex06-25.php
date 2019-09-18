$dbh = new mysqli($hostname, $username, $password, $database);
/* check connection */
if (mysqli_connect_errno()) {
   printf("Connect failed: %s\n", mysqli_connect_error());
   exit();
}

if ($dbh->query("call error_test_proc(1)"))  /*execute stored procedure*/
{
   printf("Stored procedure execution succeeded");
}
else // Stored procedure failed - show error
{
   printf("<p>Stored procedure error: MySQL error %d (SQLSTATE %s)\n %s\n",
           $dbh->errno,$dbh->sqlstate,$dbh->error);      
}  
