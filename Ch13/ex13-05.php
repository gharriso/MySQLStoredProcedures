   $mysqli->autocommit(FALSE);
   
   $mysqli->query("UPDATE account_balance
	                   SET balance=balance-$tfer_amount
	                 WHERE account_id=$from_account");
   if ($mysqli->errno)   {
      printf("transaction aborted: %s\n",$mysqli->error);
      $mysqli->rollback();
   }
   else   {
      $mysqli->query("UPDATE account_balance
	                      SET balance=balance+$tfer_amount
	                    WHERE account_id=$to_account");
      if ($mysqli->errno)      {
         printf("transaction aborted: %s\n",$mysqli->error);
         $mysqli->rollback();
      }
      else      {
         printf("transaction succeeded\n");
         $mysqli->commit();
      }
   }
