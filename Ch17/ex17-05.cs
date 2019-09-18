MySqlCommand NonSelect = new MySqlCommand("set autocommit=0",myConnection);
int RowsAffected=NonSelect.ExecuteNonQuery();

NonSelect.CommandText = "update departments "+
                           "set location=location "+
                         "where department_id=1";
RowsAffected = NonSelect.ExecuteNonQuery();
Console.WriteLine(RowsAffected + " rows affected");
