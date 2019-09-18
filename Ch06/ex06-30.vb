Dim myConnectionString As String = "Database=" & myDatabase & _
     " ;Data Source=" & myHost & _
     ";User Id=" & myUserId & ";Password=" & myPassword

Dim myConnection As New MySqlConnection(myConnectionString)

Try
    myConnection.Open()
Catch MyException As MySqlException
    Console.WriteLine("Connection error: MySQL code: " & MyException.Number & _
                      " " + MyException.Message)
End Try

Try

    Dim myCommand As New MySqlCommand("call error_test_proc(1)")
    myCommand.Connection = myConnection
    myCommand.ExecuteNonQuery()

Catch MyException As MySqlException
    Console.WriteLine("Stored procedure error: MySQL code: " & _
            MyException.Number & "  " & _
            MyException.Message)
End Try
