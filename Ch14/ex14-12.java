static public void createDemoTables(Connection connection)
{
	try
	{
		Statement s1 = connection.createStatement();
		s1.executeUpdate("CREATE TABLE DEMO" +
			"			(MyInt INT," +
			"		     MyString VARCHAR(30))");
	}
	catch(SQLException exception)
	{
	      System.out.println("Error while creating demo tables: " +
			exception.getErrorCode() +
	          " SQLSTATE:" + exception.getSQLState());
	      exception.printStackTrace();
	}
} 
