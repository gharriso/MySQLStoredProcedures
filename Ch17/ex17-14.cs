    String SqlText = "SELECT * FROM departments";
    MySqlCommand SqlCmd = new MySqlCommand(SqlText, myConnection);

    MySqlDataAdapter MyAdapter = new MySqlDataAdapter(SqlCmd);
    DataTable MyTable = new DataTable();

    MyAdapter.Fill(MyTable);
