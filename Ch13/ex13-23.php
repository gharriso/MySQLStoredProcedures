$sql="CREATE TABLE my_numbers (a_number INT)";
$dbh->exec($sql);
if ($dbh->errorCode()<>'00000') {
  $error_array=$dbh->errorInfo();
  printf("SQLSTATE          : %s\n",$error_array[0]);
  printf("MySQL error code  : %s\n",$error_array[1]);
  printf("Message           : %s\n",$error_array[2]);
}
