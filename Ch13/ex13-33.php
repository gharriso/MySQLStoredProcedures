function sql_to_html($dbh,$sql_text) {
	require_once "HTML/Table.php";
	$table = new HTML_Table('border=1');

	$sth = $dbh->prepare($sql_text) or die(implode(':', $sth->errorInfo()));
	$sth->execute() or die(implode(':', $sth->errorInfo()));
	$cols = $sth->columnCount();

	for ($i = 0; $i < $cols; $i ++) {
		$metadata = $sth->getColumnMeta($i);
		$table->setCellContents(0, $i, $metadata["name"]);
	}
	$table->setRowAttributes(0, array ("bgcolor" => "silver"));

	$r = 0;
	while ($row = $sth->fetch()) {
		$r ++;
		for ($i = 0; $i < $cols; $i ++) {
			$table->setCellContents($r, $i, $row[$i]);
		}
	}

	print $table->toHtml();
}
