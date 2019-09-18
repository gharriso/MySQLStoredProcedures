<HTML>
<TITLE>MySQL Server Statistics</TITLE>
<H1>Enter MySQL Server Details</H1>
Enter your database connection details below:
<p>
<FORM ACTION="<?php echo $_SERVER['PHP_SELF']; ?>" METHOD=POST>
  <TABLE>
      <TR><TD>Host:</TD><TD> <input type="text" name="mhost"></TD></TR>
      <TR><TD>Port:</TD><TD>  <input type="text" name="mport"></TD></TR>
      <TR><TD>Username:</TD><TD>  <input type="text" name="muser"></TD></TR>
      <TR><TD>Password:</TD><TD>  <input type="password"  name="mpass"></TD></TR>
      <TR><TD>Database:</TD><TD>  <input type="test" name="mdb"></TD></TR>
  </TABLE>
      <TR><TD><input type="submit" name="Submit" value="Submit">
</FORM>

<?php
require_once "HTML/Table.php";

$html_text = array ();

if (IsSet ($_POST['Submit'])) {
	$dsn = 'mysql:dbname='.$_POST['mdb'].';host='.$_POST['mhost'].
           ';port='.$_POST['mport'];
	$user = $_POST['muser'];
	$password = $_POST['mpass'];

	try {
		$dbh = new PDO($dsn, $user, $password);
	} catch (PDOException $e) {
		echo 'Connection failed: '.$e->getMessage();
	}
	$sql = 'call sp_mysql_info(:dbname,@server_version)';
	$sth = $dbh->prepare($sql);
	$sth->bindParam(':dbname', $_POST['mdb'], PDO::PARAM_STR, 30);
	$sth->execute() or die(implode(':', $sth->errorInfo()));

	do {
		if ($sth->columnCount() > 0) { /* Yes, there is a result set */
			$col0 = $sth->getColumnMeta(0);
			if ($col0["name"] == "table_header") { /*format this as a heading */
				$row = $sth->fetch();
				array_push($html_text, "<h2>$row[0]</h2>");
			} 
			else { /* Format this as a table */
				$table = new HTML_Table('border=1');
				for ($i = 0; $i < $sth->columnCount(); $i ++) {
					$meta = $sth->getColumnMeta($i);
					$table->setCellContents(0, $i, $meta["name"]);
				}
				$table->setRowAttributes(0, array ("bgcolor" => "silver"));

				#Loop through the rows
				$r = 0;
				while ($row = $sth->fetch()) {
					#Loop through the columns in the row
					$r ++;
					for ($i = 0; $i < $sth->columnCount(); $i ++) {
						$table->setCellContents($r, $i, $row[$i]);
					}
				}
				array_push($html_text, $table->toHtml());
			}
		}
	}
	while ($sth->nextRowset());

	foreach ($dbh->query("SELECT @server_version") as $row) {
		$mysql_version = $row[0];
	}

	print "<h1>MySQL Server status and statistics</h1>";
	printf("<b>Host:</b> %s<br>", $_POST['mhost']);
	printf("<b>Port:</b> %s<br>", $_POST['mport']);
	printf("<b>Version:</b> %s<br>", $mysql_version);
	foreach($html_text as $html) {
		print $html;
	}
}
?>
</html>
