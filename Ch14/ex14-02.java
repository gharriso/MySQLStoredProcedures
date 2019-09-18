Class.forName("com.mysql.jdbc.Driver").newInstance();
			
Connection myConnection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/test?user=root&password=secret");
