	$dbh->{AutoCommit} = 0;

	$dbh->do(
		"UPDATE account_balance
	        SET balance=balance-$tfer_amount
	      WHERE account_id=$from_account"
	);
	if ($DBI::err) {
		print "transaction aborted: ".$DBI::errstr . "\n";
		$dbh->rollback;
	}
	else {
		$dbh->do(
			"UPDATE account_balance
	            SET balance=balance+$tfer_amount
	          WHERE account_id=$to_account"
		);
		if ($DBI::err) {
			print "transaction aborted: ".$DBI::errstr . "\n";
			$dbh->rollback;
		}
		else {
			printf("transaction succeeded\n");
			$dbh->commit;
		}
	}
