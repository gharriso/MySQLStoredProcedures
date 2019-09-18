$sql = "call sp_rep_customer_count(?,?)";
$sth = $dbh->prepare($sql)  or die(implode(':', $sth->errorInfo()));
$sth->bindParam(1,$sales_rep_id,PDO::PARAM_STR,4000);
$sth->bindParam(2,$customer_count, PDO::PARAM_INT|PDO::PARAM_INPUT_OUTPUT);
$sth->execute()  or die(implode(':', $sth->errorInfo()));
