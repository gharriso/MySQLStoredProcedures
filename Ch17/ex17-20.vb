        Dim SpSimple As MySqlCommand
        SpSimple = New MySqlCommand("sp_simple", myConnection)
        SpSimple.CommandType = CommandType.StoredProcedure
        SpSimple.ExecuteNonQuery()
