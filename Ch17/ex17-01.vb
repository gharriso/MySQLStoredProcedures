
   Sub Main(ByVal CmdArgs() As String)

        Dim myHost As String = CmdArgs(0)
        Dim myUserId As String = CmdArgs(1)
        Dim myPassword As String = CmdArgs(2)
        Dim myDatabase As String = CmdArgs(3)

        Dim myConnectionString As String = "Database=" & myDatabase & _
            " ;Data Source=" & myHost & _
            ";User Id=" & myUserId & ";Password=" & myPassword

    
        Dim myConnection As New MySqlConnection(myConnectionString)

        Try
            myConnection.Open()
            Console.WriteLine("Connection succeeded")
        Catch MyException As MySqlException
            Console.WriteLine("Connection error: MySQL code: " _
               & MyException.Number & " " & MyException.Message)
        End Try
