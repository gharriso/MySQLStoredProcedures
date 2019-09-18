       MySqlCommand FCmd = new MySqlCommand("my_date", myConnection);
       FCmd.CommandType = CommandType.StoredProcedure;
       MySqlParameter rv = FCmd.Parameters.Add("rv", MySqlDbType.String);
       rv.Direction = ParameterDirection.ReturnValue;
       FCmd.ExecuteNonQuery();
       Console.WriteLine("return value=" + rv.Value);
