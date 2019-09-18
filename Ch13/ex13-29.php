$sql = 'INSERT INTO my_numbers VALUES(1),(2),(3)';

$sth = $dbh->prepare($sql);
$sth->execute() or die (implode(':',$sth->errorInfo()));
