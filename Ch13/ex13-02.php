	$mysqli->query("CREATE TABLE guy_1 (guys_integers INT)");
	if ($mysqli->errno <> 0 ) {
		printf("Statement failed %d: (%s) %s\n"
        ,$mysqli->errno,$mysqli->sqlstate,$mysqli->error);
	}
