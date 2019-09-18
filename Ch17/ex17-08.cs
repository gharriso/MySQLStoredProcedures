String SQLText = "UPDATE employees " + 
                  "   SET salary= ?NewSal" + 
                  " WHERE employee_id= ?EmpID";
MySqlCommand ParameterSQL = new MySqlCommand(SQLText,myConnection);
    
MySqlParameter EmpSal  = ParameterSQL.Parameters.Add(
                               "?NewSal", MySqlDbType.Float);
MySqlParameter EmpId = ParameterSQL.Parameters.Add(
                               "?EmpID", MySqlDbType.Int16);
             
for(i=1;i<=4;i++)
   {
        EmpSal.Value = EmployeeSal[i];
        EmpId.Value = EmployeeID[i];
        RowCount = ParameterSQL.ExecuteNonQuery();
    }
