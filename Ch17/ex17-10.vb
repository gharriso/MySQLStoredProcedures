            Dim SelectText As String
            Dim SelectStatement As MySqlCommand
            Dim SelectReader As MySqlDataReader
            SelectText = "SELECT department_id, department_name FROM departments"
            SelectStatement = New MySqlCommand(SelectText, myConnection)
            SelectReader = SelectStatement.ExecuteReader()
            While (SelectReader.Read())
                Console.WriteLine(SelectReader.GetInt32(0).ToString + _
                        " " + SelectReader.GetString(1))
            End While
            SelectReader.Close()
