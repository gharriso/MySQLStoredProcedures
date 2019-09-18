 MySqlCommand NonSelect = new MySqlCommand(
           "DELETE FROM employees WHERE employee_id=2001", myConnection);
 int RowsAffected = NonSelect.ExecuteNonQuery();
