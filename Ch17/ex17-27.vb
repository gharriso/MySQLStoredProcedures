Dim SpCmd As MySqlCommand
SpCmd = New MySqlCommand("sp_one_result_set", myConnection)
SpCmd.CommandType = CommandType.StoredProcedure
Dim MyReader As MySqlDataReader = SpCmd.ExecuteReader
While MyReader.Read
	Console.Write(MyReader.GetInt32(0).ToString + _
                      "" & Microsoft.VisualBasic.Chr(9) & "")
    Console.WriteLine(MyReader.GetString(1))
End While
MyReader.Close()
