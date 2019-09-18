MySqlConnection myConnection;
myConnection = new MySqlConnection();
myConnection.ConnectionString = "database="+database+";server="+server+
                                ";user id="+user+";Password="+password;
try  {
    myConnection.Open();
}
catch (MySqlException MyException)            {
    Console.WriteLine("Connection error: MySQL code: "+MyException.Number
                     +" "+ MyException.Message);
}

try {
            
   MySqlCommand myCommand = new MySqlCommand("call error_test_proc(1)",
                                              myConnection);            
   myCommand.ExecuteNonQuery();
}
catch (MySqlException MyException)            {
   Console.WriteLine("Stored procedure error: MySQL code: " + MyException.Number
                     + "  " + MyException.Message);
}
