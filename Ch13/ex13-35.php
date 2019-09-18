$sql = 'call stored_proc_with_1_result()';
foreach ($dbh->query($sql) as $row) {
  printf("%d \t %s\n",$row[0],$row[1]);
} 
