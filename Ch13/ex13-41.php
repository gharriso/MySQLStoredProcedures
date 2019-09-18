function many_results($dbh, $sql_text) {
	$sth = $dbh->prepare($sql_text);
	$sth->execute() or die(implode(':', $sth->errorInfo()));

	do {
		if ($sth->columnCount() > 0) { /* Yes, there is a result set */

			#Print off the column names
			for ($i = 0; $i < $sth->columnCount(); $i ++) {
				$meta = $sth->getColumnMeta($i);
				printf("%s\t", $meta["name"]);
			}
			printf("\n");

			#Loop through the rows
			while ($row = $sth->fetch()) {
				#Loop through the columns
				for ($i = 0; $i < $sth->columnCount(); $i ++) {
					printf("%s\t", $row[$i]);
				}
				printf("\n");

			}
			printf("-------------------\n");
		}
	}
	while ($sth->nextRowset());
}
