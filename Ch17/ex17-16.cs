       static void CreateDemoTables()
        {
            String MySqlText= "CREATE TABLE DEMO" +  
                              "  (MyInt INT," +
                              "   MyString VARCHAR(30)) ";
            
            try
            {
                MySqlCommand CrDemoSQL=new MySqlCommand(MySqlText,myConnection);
                CrDemoSQL.ExecuteNonQuery();
            }
            catch(MySqlException MyException)
            {
                Console.WriteLine("Error creating demo tables:");
                Console.WriteLine(MyException.Number + 
                                  ": " + MyException.Message);
                Console.WriteLine(MyException.StackTrace);
            }
        }
