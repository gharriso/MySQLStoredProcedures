MySqlCommand SpCmd;
SpCmd = new MySqlCommand("sp_one_result_set", myConnection);
SpCmd.CommandType = CommandType.StoredProcedure;
MySqlDataReader MyReader=SpCmd.ExecuteReader();
while (MyReader.Read())
{
	Console.Write(MyReader.GetInt32(0)+"\t");
    Console.WriteLine(MyReader.GetString(1));
}
