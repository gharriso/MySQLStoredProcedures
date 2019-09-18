        Dim TabChr As Char = Microsoft.VisualBasic.Chr(9)
        Dim SpCmd As MySqlCommand
        SpCmd = New MySqlCommand("sp_two_results", myConnection)
        SpCmd.CommandType = CommandType.StoredProcedure

        Dim MyAdapter As MySqlDataAdapter = New MySqlDataAdapter(SpCmd)
        Dim SpDataSet As DataSet = New DataSet
        MyAdapter.Fill(SpDataSet)

        For Each SpTable As DataTable In SpDataSet.Tables
            For Each SpCol As DataColumn In SpTable.Columns
                Console.Write(SpCol.ToString() + TabChr)
            Next
            Console.WriteLine()

            For Each SpRow As DataRow In SpTable.Rows
                For Each SpCol As DataColumn In SpTable.Columns
                    Console.Write(SpRow(SpCol).ToString + TabChr)
                Next
                Console.WriteLine()
            Next
        Next
