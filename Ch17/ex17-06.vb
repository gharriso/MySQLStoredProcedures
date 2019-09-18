For i = 1 To N
    NonSelect.CommandText = "UPDATE employees " + _
                            "   SET salary= " + EmployeeSal(i).ToString + _
                            " WHERE employee_id=" + EmployeeID(i).ToString
    NonSelect.ExecuteNonQuery()

Next
