$sql="call sp_rep_customer_count(1,@customer_count)";
$sth = $dbh->prepare($sql);
$sth->execute() or die (implode(':',$sth->errorInfo()));

# Now get the output variable

$sql="SELECT @customer_count";
foreach ($dbh->query($sql) as $row) {
  printf("Customer count=%d\n",$row[0]);
}
