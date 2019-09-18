static public void createDemoTables(Connection myConnection)
	throws SQLException
{
	Statement s1 = connection.createStatement();
	s1.executeUpdate("CREATE TABLE DEMO " +
			"			(MyInt INT, " +
			"		     MyString VARCHAR(30))");
}
