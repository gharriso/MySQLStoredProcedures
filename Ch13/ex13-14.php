	$sql = "CALL customers_for_rep(?)";
	$stmt = $mysqli->prepare($sql);
	if ($mysqli->errno) {die($mysqli->errno.":: ".$mysqli->error);}
	
	$stmt->bind_param("i", $in_sales_rep_id);	
	$in_sales_rep_id = 1;
	$stmt->execute();
	if ($mysqli->errno) {die($mysqli->errno.": ".$mysqli->error);}
	
	$stmt->bind_result($customer_id,$customer_name); 
	while ($stmt->fetch()) {
		printf("%d %s \n", $customer_id,$customer_name);
	}
