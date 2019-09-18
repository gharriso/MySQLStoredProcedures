$sth = $dbh->prepare("SELECT employee_id,surname,date_of_birth
                        FROM employees where employee_id=1");
$sth->execute() or die (implode(':',$sth->errorInfo()));
$cols=$sth->columnCount();

for ($i=0; $i<$cols ;$i++) {
  $metadata=$sth->getColumnMeta($i);
  printf("\nDetails for column %d\n",$i+1);
  printf("     Name:  %s\n",$metadata["name"]);
  printf(" Datatype:  %s\n",$metadata["native_type"]);
  printf("   Length:  %d\n",$metadata["len"]);
  printf(" Precision: %d\n",$metadata["precision"]);
}
