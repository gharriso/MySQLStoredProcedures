$sql="CREATE TABLE my_numbers (a_number INT)";
$dbh->exec($sql);  
if ($dbh->errorCode()<>'00000') {
  die("Error: ".implode(': ',$dbh->errorInfo())."\n");
}
