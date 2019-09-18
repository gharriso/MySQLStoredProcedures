Statement stmt2 = myConnection.createStatement();
ResultSet results = stmt2.executeQuery("SELECT department_id, department_name " +
            "                           FROM departments");
while(results.next())
{
	int departmentID = results.getInt("department_id");  // Get column by name
	String departmentName = results.getString(2);        // Got column by number
	System.out.println(departmentID + ":" + departmentName);
}
results.close();
