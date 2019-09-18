        Dim SpCmd As MySqlCommand
        SpCmd = New MySqlCommand("sp_Simple_Parameter", myConnection)
        SpCmd.CommandType = CommandType.StoredProcedure
        Dim Parm1 As MySqlParameter
        Parm1 = SpCmd.Parameters.Add("in_autocommit", MySqlDbType.Int32)
        Parm1.Value = 0
        SpCmd.ExecuteNonQuery()
