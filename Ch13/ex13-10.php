	$sql = 'call simple_stored_proc()';
	$mysqli->query($sql);
	if ($mysqli->errno) {
		die("Execution failed: ".$mysqli->errno.": ".$mysqli->error);
	}
	else {
		printf("Stored procedure execution succeeded\n");
	}
