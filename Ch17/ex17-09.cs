String SelectText = "SELECT department_id, department_name FROM departments";
MySqlCommand SelectStatement = new MySqlCommand(SelectText, myConnection);
MySqlDataReader SelectReader = SelectStatement.ExecuteReader();
while (SelectReader.Read())
  {
      Console.WriteLine(SelectReader.GetInt32(0) + "\t" +  
                        SelectReader.GetString(1));
  }
SelectReader.Close();
