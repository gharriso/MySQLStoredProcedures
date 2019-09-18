    void FindButton_Click(object sender, EventArgs e)
    {
        //Arrays of grids and literals for our output.
        System.Web.UI.WebControls.DataGrid[] DataGrids;
        DataGrids = new System.Web.UI.WebControls.DataGrid[20];
        System.Web.UI.WebControls.Literal[] Literals;
        Literals = new System.Web.UI.WebControls.Literal[20];
            
        
        String myConnectionString = "Database=" + tDatabase.Text +
           " ;Host=" + tHost.Text +
           ";UserName=" + tUsername.Text+ ";Password=" + tPassword.Text;


        MySqlConnection myConnection = new MySqlConnection();
        myConnection.ConnectionString = myConnectionString;

        try
        {
            myConnection.Open();
            MySqlCommand SpCmd = new MySqlCommand("sp_mysql_info", myConnection);
            SpCmd.CommandType = CommandType.StoredProcedure;
            MySqlParameter InDbParm = SpCmd.Parameters.Add(
	                       "in_database",MySqlDbType.String);
            InDbParm.Value = tDatabase.Text;
            MySqlParameter OutMyVersion = SpCmd.Parameters.Add(
                           "server_version", MySqlDbType.String);
            OutMyVersion.Direction = ParameterDirection.Output;

            MySqlDataAdapter MyAdapter = new MySqlDataAdapter(SpCmd);
            MyAdapter.SelectCommand = SpCmd;
            DataSet SpDataSet = new DataSet();
            MyAdapter.Fill(SpDataSet);

            ReportHeaderl.Text = "<h1>MySQL Server status and statistics</h1>" +
                     "<b>Host:</b>"+tHost.Text+"<br>"+
                     " <b>Port:</b> "+tPort.Text+"<br>"+
                     "<b>Version:</b>"+OutMyVersion.Value+"<br>";

            int grid_no = 0;
            int heading_no=0;
            foreach (DataTable SpTable in SpDataSet.Tables) {
                if (SpTable.Columns[0].ColumnName == "table_header")
                {
                    Literals[heading_no]=new Literal();
                    Literals[heading_no].Text="<h2>"+ SpTable.Rows[0][0]+"</h2>";
                    PlaceHolder.Controls.Add(Literals[heading_no]);
                    heading_no++;
                }
                else
                {
                    DataGrids[grid_no] = new DataGrid();
                    DataGrids[grid_no].DataSource = SpTable;
                    DataGrids[grid_no].DataBind();
                    DataGrids[grid_no].BorderWidth = 1;
                    DataGrids[grid_no].HeaderStyle.BackColor =
                         System.Drawing.Color.Silver;
                    PlaceHolder.Controls.Add(DataGrids[grid_no]);
                    grid_no++;
                }
            }



        }
        catch (MySqlException MyException)
        {
            Response.Write("Connection error: MySQL code: " + MyException.Number
                              + " " + MyException.Message);
        }


    }
