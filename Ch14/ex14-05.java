Statement stmt3 = myConnection.createStatement();
ResultSet results2 = stmt2.executeQuery("SELECT *" +
             "                           FROM departments");
ResultSetMetaData meta1 = results2.getMetaData();
		
for (int i = 1; i <= meta1.getColumnCount(); i++)
{
	System.out.println("Column " + i + " "
					+ meta1.getColumnName(i) + " ("
					+ meta1.getColumnTypeName(i) + ")");
}
