$sth = $dbh->prepare("call stored_proc_with_2_results( $employee_id )");
$sth->execute() or die (implode(':',$sth->errorInfo()));

while ($row1=$sth->fetch()) {
  printf("%d %s %s\n",$row1['employee_id'],$row1['surname'],$row1['firstname']);
}

$sth->nextRowset();

while ($row2=$sth->fetch()) {
  printf("%d %s \n",$row2['customer_id'],$row2['customer_name']);
}
