MySqlCommand SpCmd;
SpCmd = new MySqlCommand("sp_Simple_Parameter", myConnection);
SpCmd.CommandType = CommandType.StoredProcedure;
MySqlParameter Parm1 = SpCmd.Parameters.Add(
                       "in_autocommit",MySqlDbType.Int32);

Parm1.Value = 0;

SpCmd.ExecuteNonQuery();
