

static void Main(string[] args)
    {
        String myHost=args[0];
        String myUserId=args[1];
        String myPassword=args[2];
        String myDatabase=args[3];

        String myConnectionString = "Database=" + myDatabase +
               " ;Host=" + myHost +
               ";UserName=" + myUserId  + ";Password=" + myPassword;

        MySqlConnection myConnection;
        myConnection = new MySqlConnection();
        myConnection.ConnectionString = myConnectionString;

        try  {
             myConnection.Open();
             Console.WriteLine("Connection succeded");
        }
        catch (MySqlException MyException)            {
             Console.WriteLine("Connection error: MySQL code: "+MyException.Number
                               +" "+ MyException.Message);
            }

