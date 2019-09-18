            String SqlText = "SELECT * FROM departments";
            MySqlCommand SqlCmd = new MySqlCommand(SqlText, myConnection);

            MySqlDataAdapter MyAdapter=new MySqlDataAdapter(SqlCmd);
            DataSet MyDataSet=new DataSet();
            int rows = MyAdapter.Fill(MyDataSet);
            
            DataTable MyTable=MyDataSet.Tables[0];

            //Write column headings
            foreach(DataColumn MyColumn in MyTable.Columns)
            {
                Console.Write(MyColumn.Caption+"\t");
            }
            Console.WriteLine();

            //Write Column Rows
            foreach(DataRow MyRow in MyTable.Rows)
            {
                foreach(DataColumn MyColumn in MyTable.Columns)
                {
                    Console.Write(MyRow[MyColumn]+"\t");
                }
                Console.WriteLine();
            }
