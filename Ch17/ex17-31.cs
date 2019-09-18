static void EmployeeReport(int EmployeeId)
{
      MySqlCommand SpCmd = new MySqlCommand("sp_employee_report", myConnection);
      SpCmd.CommandType = CommandType.StoredProcedure;
      MySqlParameter Param_empid = SpCmd.Parameters.Add(
                                   "in_emp_id", MySqlDbType.Int32);

      Param_empid.Value = EmployeeId;
      MySqlDataReader EmpReader=SpCmd.ExecuteReader();

      do
      {
           //Print Column Names
           Console.WriteLine("-------------------------------------");
           for (int i = 0; i < EmpReader.FieldCount; i++)
           {
               Console.Write(EmpReader.GetName(i)+"\t");
           }
           Console.WriteLine("\n-----------------------------------");
           //Print out the row values
           while (EmpReader.Read())
           {
               for (int i = 0; i < EmpReader.FieldCount; i++)
               {
                   Console.Write(EmpReader.GetString(i)+"\t");
               }
               Console.WriteLine();
            }
        } while (EmpReader.NextResult());
        EmpReader.Close();
   }
