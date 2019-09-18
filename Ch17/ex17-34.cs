            MySqlCommand SpCmd;
            SpCmd = new MySqlCommand("sp_two_results", myConnection);
            SpCmd.CommandType = CommandType.StoredProcedure;

            MySqlDataAdapter MyAdapter = new MySqlDataAdapter(SpCmd);
            MyAdapter.SelectCommand = SpCmd;
            DataSet SpDataSet = new DataSet();
            MyAdapter.Fill(SpDataSet);

            foreach (DataTable SpTable in SpDataSet.Tables)
            {
                foreach (DataColumn SpCol in SpTable.Columns)
                {
                    Console.Write(SpCol.ToString() + "\t");
                }
                Console.WriteLine();

                foreach (DataRow SpRow in SpTable.Rows)
                {
                    foreach (DataColumn SpCol in SpTable.Columns)
                    {
                        Console.Write(SpRow[SpCol] + "\t");
                    }
                    Console.WriteLine();
                }
            }
