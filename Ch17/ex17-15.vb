  Sub CreateDemoTables()
        Dim MySqlText As String
        MySqlText = "CREATE TABLE DEMO" & _
                    "  (MyInt INT," & _
                    "     MyString VARCHAR(30)) "

        Dim CrDemoSQL As MySqlCommand

        Try
            CrDemoSQL = New MySqlCommand(MySqlText, myConnection)
            CrDemoSQL.ExecuteNonQuery()
        Catch MyException As MySqlException
            Console.WriteLine("Error creating demo tables:")
            Console.WriteLine(MyException.Number.ToString & ": " & _
                              MyException.Message)
            Console.WriteLine(MyException.StackTrace)
        End Try

    End Sub
