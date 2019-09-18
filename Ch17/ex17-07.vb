            Dim ParameterSQL As MySqlCommand
            Dim SQLText As String
            SQLText = "UPDATE employees " + _
                      "   SET salary= ?NewSal" + _
                      " WHERE employee_id= ?EmpID"
            ParameterSQL = New MySqlCommand(SQLText, myConnection)

            Dim EmpSal As MySqlParameter
            EmpSal = ParameterSQL.Parameters.Add("?NewSal", MySqlDbType.Float)
            Dim EmpId As MySqlParameter
            EmpId = ParameterSQL.Parameters.Add("?EmpID", MySqlDbType.Int16)
            Dim RowCount As Int16

            For i = 1 To N
                EmpSal.Value = EmployeeSal(i)
                EmpId.Value = EmployeeID(i)
                RowCount = ParameterSQL.ExecuteNonQuery()
                Console.WriteLine(RowCount.ToString)
            Next
