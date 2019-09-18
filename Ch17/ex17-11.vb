SelectText = "SELECT * FROM departments"
SelectStatement = New MySqlCommand(SelectText, myConnection)
SelectReader = SelectStatement.ExecuteReader()
For i = 0 To SelectReader.FieldCount() - 1
    Console.WriteLine(SelectReader.GetName(i) + " " + _
                      SelectReader.GetFieldType(i).ToString)
Next
