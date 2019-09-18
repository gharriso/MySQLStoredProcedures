       static void CustomerSales(int CustomerId)
        {
            MySqlCommand SpCustSales;
            MySqlParameter PCustId,PSalesTotal;
            MySqlDataReader CustReader;

            SpCustSales = new MySqlCommand("sp_custsales", myConnection);
            SpCustSales.CommandType = CommandType.StoredProcedure;
            PCustId = SpCustSales.Parameters.Add(
                                   "in_customer_id", MySqlDbType.Int32);
            PSalesTotal = SpCustSales.Parameters.Add(
                                   "out_sales_total", MySqlDbType.Float);
            PSalesTotal.Direction = ParameterDirection.Output;

            PCustId.Value = CustomerId;
            CustReader=SpCustSales.ExecuteReader();
            while (CustReader.Read())
            {
                Console.WriteLine(CustReader.GetString(0));
            }
            CustReader.Close();
            Console.WriteLine(PSalesTotal.Value);

            Console.WriteLine("====");

        }
