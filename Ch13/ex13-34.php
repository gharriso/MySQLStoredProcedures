$sql='call simple_stored_proc()';
$dbh->exec($sql);
if ($dbh->errorCode()<>'00000') {
  die("Error: ".implode(': ',$dbh->errorInfo())."\n");
}
