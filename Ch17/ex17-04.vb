Dim NonSelect As MySqlCommand
NonSelect = New MySqlCommand( _
        "DELETE FROM employees WHERE employee_id=2001", myConnection)
Dim RowsAffected As Int16
RowsAffected = NonSelect.ExecuteNonQuery()
