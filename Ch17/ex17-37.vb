Sub CustomerSales(ByVal CustomerId As Integer)

        Dim SpCustSales As MySqlCommand
        Dim PCustId As MySqlParameter
        Dim PSalesTotal As MySqlParameter
        Dim CustReader As MySqlDataReader

        SpCustSales = New MySqlCommand("sp_custsales", myConnection)
        SpCustSales.CommandType = CommandType.StoredProcedure
        PCustId = SpCustSales.Parameters.Add("in_customer_id", MySqlDbType.Int32)
        PSalesTotal = SpCustSales.Parameters.Add("out_sales_total", MySqlDbType.Float)
        PSalesTotal.Direction = ParameterDirection.Output

        PCustId.Value = CustomerId
        CustReader = SpCustSales.ExecuteReader()
        While CustReader.Read()
            Console.WriteLine(CustReader.GetString(0))
        End While
        CustReader.Close()
        Console.WriteLine(PSalesTotal.Value)

    End Sub
