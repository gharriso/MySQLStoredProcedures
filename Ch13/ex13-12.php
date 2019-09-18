	$sql = "call department_list()";
	$results = $mysqli->query($sql);
	if ($mysqli->errno) {
		die("Execution failed: ".$mysqli->errno.": ".$mysqli->error);
	}
	while ($row = $results->fetch_object()) {
		printf("%s\t%s\n", $row->department_name, $row->location);
	}
