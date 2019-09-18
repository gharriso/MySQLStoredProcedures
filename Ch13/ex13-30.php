$sql='SELECT department_id,department_name FROM departments LIMIT 5';

$sth=$dbh->prepare($sql) or die (implode(':',$sth->errorInfo()));

$sth->execute() or die (implode(':',$sth->errorInfo()));

while($row=$sth->fetch()) {
  printf("%d \t %s \n",$row['department_id'],$row['department_name']);
}
