<?php

$dsn = 'mysql:dbname=prod;host=localhost;port=3305';
$user = 'root';
$password = 'secret';

try {
  $dbh = new PDO($dsn, $user, $password);
}
catch (PDOException $e) {
  die('Connection failed: '.$e->getMessage());
}

print "Connected\n";

?>
