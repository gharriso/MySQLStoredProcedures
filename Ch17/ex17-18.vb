  Sub TferFunds(ByVal FromAccount As Integer, _
                ByVal ToAccount As Integer, _
                ByVal TferAmount As Single)

        Dim TransSQL As String = "UPDATE account_balance " + _
                                  " SET balance=balance+?tfer_amount " + _
                                  "WHERE account_id=?account_id"
        Dim TransCmd As MySqlCommand = New MySqlCommand(TransSQL, myConnection)
        Dim P_tfer_amount As MySqlParameter = _
            TransCmd.Parameters.Add("?tfer_amount", MySqlDbType.Float)
        Dim P_account_id As MySqlParameter = _
            TransCmd.Parameters.Add("?account_id", MySqlDbType.Int32)
        Dim myTransaction As MySqlTransaction = myConnection.BeginTransaction
        Try
            'Remove amount from FromAccount
            P_tfer_amount.Value = TferAmount * -1
            P_account_id.Value = FromAccount
            TransCmd.ExecuteNonQuery()
            'Add amount to ToAccount
            P_tfer_amount.Value = TferAmount
            P_account_id.Value = ToAccount
            TransCmd.ExecuteNonQuery()

            myTransaction.Commit()
            Console.WriteLine("Transaction Succeded")

        Catch TransException As MySqlException
            Console.WriteLine("Error in transaction: ")
            Console.WriteLine(TransException.Message)
            Try
                myTransaction.Rollback()
                Console.WriteLine("Transaction rollback")
            Catch RollbackException As MySqlException
                Console.WriteLine("Failed to rollback transaction:")
                Console.WriteLine(RollbackException.Message)
            End Try
        End Try
 End Sub
