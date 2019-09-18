        Dim TabChr As Char = Microsoft.VisualBasic.Chr(9)
        Dim SpCmd As MySqlCommand
        SpCmd = New MySqlCommand("sp_two_results", myConnection)
        SpCmd.CommandType = CommandType.StoredProcedure
        Dim MyReader As MySqlDataReader = SpCmd.ExecuteReader
        While MyReader.Read
            Console.Write(MyReader.GetString(0) + TabChr)
            Console.Write(MyReader.GetString(1))
            Console.WriteLine(MyReader.GetString(2))
        End While
        MyReader.NextResult()
        While MyReader.Read
            Console.Write(MyReader.GetInt32(0).ToString +TabChr)
            Console.WriteLine(MyReader.GetString(1))
        End While
        MyReader.Close()
