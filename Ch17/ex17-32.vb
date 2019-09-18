Sub EmployeeReport(ByVal EmployeeId As Integer)

        Dim i As Integer = 0
        Dim TabChr As Char = Microsoft.VisualBasic.Chr(9)
        Dim RetChr As Char = Microsoft.VisualBasic.Chr(10)
        Dim SpCmd As MySqlCommand
        SpCmd = New MySqlCommand("sp_employee_report", myConnection)
        SpCmd.CommandType = CommandType.StoredProcedure
        Dim Param_empid As MySqlParameter
        Param_empid = SpCmd.Parameters.Add("in_emp_id", MySqlDbType.Int32)
        Param_empid.Value = EmployeeId
        Dim EmpReader As MySqlDataReader = SpCmd.ExecuteReader
        Do
            Console.WriteLine("-------------------------------------")

            For i = 0 To EmpReader.FieldCount - 1
                Console.Write(EmpReader.GetName(i) + TabChr) 
            Next

            Console.WriteLine(RetChr+ "-----------------------------------")
            While EmpReader.Read()

                For i = 0 To EmpReader.FieldCount - 1
                    Console.Write(EmpReader.GetString(i) + TabChr)
                Next
                Console.WriteLine()
            End While
        Loop While EmpReader.NextResult()
        EmpReader.Close()
    End Sub
