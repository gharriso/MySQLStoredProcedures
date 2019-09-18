$sql='call stored_proc_with_1_result()';

$sth=$dbh->prepare($sql) or die (implode(':',$sth->errorInfo()));

$sth->execute() or die (implode(':',$sth->errorInfo()));

while($row=$sth->fetch()) {
  printf("%s \t %s \n",$row['department_name'],$row['location']);
}
