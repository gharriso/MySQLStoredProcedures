  $dbh->beginTransaction();
  
  $dbh->exec("UPDATE account_balance
	             SET balance=balance-$tfer_amount
	           WHERE account_id=$from_account");

  if ($dbh->errorCode()<>'00000') {
    printf("transaction aborted: %s\n",implode(': ',$dbh->errorInfo()));
    $dbh->rollback();
  }
  
  else
    {
      $dbh->exec("UPDATE account_balance
	                 SET balance=balance+$tfer_amount
	               WHERE account_id=$to_account");
      if ($dbh->errorCode()<>'00000')
	  {
	       printf("transaction aborted: %s\n",implode(': ',$dbh->errorInfo()));
	       $dbh->rollback();
	  }
      else
	  {
	       printf("transaction succeeded\n");
	       $dbh->commit();
	   }
   }
