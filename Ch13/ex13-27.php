$sql = 'SELECT department_id,department_name FROM departments';
foreach ($dbh->query($sql) as $row) {
  printf("%d \t %s\n",$row['department_id'],$row['department_name']);
}
