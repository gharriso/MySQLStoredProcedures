static void TferFunds(int FromAccount, int ToAccount, float TferAmount)
   {
      String TransSQL = "UPDATE account_balance " +
                         "  SET balance=balance+?tfer_amount " +
                         "WHERE account_id=?account_id";
      MySqlCommand TransCmd = new MySqlCommand(TransSQL, myConnection);
      MySqlParameter P_tfer_amount = TransCmd.Parameters.Add("?tfer_amount",
                                                         MySqlDbType.Float);
      MySqlParameter P_account_id = TransCmd.Parameters.Add("?account_id", 
                                                         MySqlDbType.Int32);

      MySqlTransaction myTransaction = myConnection.BeginTransaction();
      try
        {
           //Remove amount from from_account
           P_tfer_amount.Value = TferAmount * -1;
           P_account_id.Value = FromAccount;
           TransCmd.ExecuteNonQuery();
           //Add amount to to_account;
           P_tfer_amount.Value = TferAmount;
           P_account_id.Value = ToAccount;
           TransCmd.ExecuteNonQuery();

           myTransaction.Commit();
           Console.WriteLine("Transaction Succeded");
         }
       catch (MySqlException TransException)
         {
           Console.WriteLine("Error in transaction: ");
           Console.WriteLine(TransException.Message);
           try
             {
                 myTransaction.Rollback();
                 Console.WriteLine("Transaction rollback");
              }
           catch (MySqlException RollbackException)
              {
                 Console.WriteLine("Failed to rollback transaction:");
                 Console.WriteLine(RollbackException.Message);
               }
          }
      }
