$sql='SELECT customer_id,customer_name
        FROM customers
       WHERE sales_rep_id=:sales_rep_id
         AND contact_surname=:surname';
$sth = $dbh->prepare($sql);
if ($dbh->errorCode()<>'00000') {
  die("Error: ".implode(': ',$dbh->errorInfo())."\n");
}

$sth->bindParam(':sales_rep_id', $sales_rep_id, PDO::PARAM_INT);
$sth->bindParam(':surname',      $surname,      PDO::PARAM_STR, 30);

$sales_rep_id=41;
$surname = 'SMITH';
$sth->execute();
if ($dbh->errorCode()<>'00000') {
  die("Error: ".implode(': ',$dbh->errorInfo())."\n");
}
while($row=$sth->fetch()) {
  printf("%d %s \n",$row['customer_id'],$row['customer_name']);
}
