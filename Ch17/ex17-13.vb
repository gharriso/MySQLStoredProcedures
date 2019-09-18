        Dim TabChr As Char = Microsoft.VisualBasic.Chr(9)
        Dim SqlText As String = "SELECT * FROM departments"
        Dim SqlCmd As MySqlCommand = New MySqlCommand(SqlText, myConnection)


        Dim MyAdapter As MySqlDataAdapter = New MySqlDataAdapter(SqlCmd)

        Dim MyDataSet As DataSet = New DataSet
        Dim rows As Integer = MyAdapter.Fill(MyDataSet)

        Dim MyTable As DataTable = MyDataSet.Tables(0)

        For Each MyColumn As DataColumn In MyTable.Columns
            Console.Write(MyColumn.Caption + "" & TabChr & "")
        Next
        Console.WriteLine()
        For Each MyRow As DataRow In MyTable.Rows
            For Each MyColumn As DataColumn In MyTable.Columns
                Console.Write(MyRow(MyColumn).ToString + "" & TabChr & "")
            Next
            Console.WriteLine()
        Next
    End Sub
