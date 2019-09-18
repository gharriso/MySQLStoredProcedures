       Dim FCmd As MySqlCommand = New MySqlCommand("my_date", myConnection)
       FCmd.CommandType = CommandType.StoredProcedure
       Dim rv As MySqlParameter = FCmd.Parameters.Add("rv", MySqlDbType.String)
       rv.Direction = ParameterDirection.ReturnValue
       FCmd.ExecuteNonQuery()
       Console.WriteLine("return value=" + rv.Value)
