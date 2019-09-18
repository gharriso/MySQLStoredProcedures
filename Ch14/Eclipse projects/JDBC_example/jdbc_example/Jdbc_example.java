package jdbc_example;

import java.sql.*;
import java.util.Date;
import com.sun.rowset.CachedRowSetImpl;


public class Jdbc_example {
	Connection myConnection;

	public Jdbc_example() {

	}

	private void empsInDept(Connection myConnect, int deptId)
			throws SQLException {

		CallableStatement cStmt = myConnect
				.prepareCall("{CALL sp_emps_in_dept(?)}");
		cStmt.setInt(1, deptId);
		cStmt.execute();
		ResultSet rs1 = cStmt.getResultSet();
		while (rs1.next()) {
			System.out.println(rs1.getString("department_name") + " "
					+ rs1.getString("location"));
		}
		rs1.close();

		/* process second result set */
		if (cStmt.getMoreResults()) {
			ResultSet rs2 = cStmt.getResultSet();
			while (rs2.next()) {
				System.out.println(rs2.getInt(1) + " " + rs2.getString(2) + " "
						+ rs2.getString(3));
			}
			rs2.close();
		}
		cStmt.close();
	}

	public static void dynamic_proc(Connection myConnect, String sqltext)
			throws SQLException {

		CallableStatement cs = myConnect.prepareCall("{CALL " + sqltext + "}");
		boolean MoreResultSets = cs.execute();
		while (MoreResultSets) {
			ResultSet rs = cs.getResultSet();
			ResultSetMetaData rsmd = rs.getMetaData();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
				System.out.print(rsmd.getColumnName(i) + "\t");
			}
			System.out.print("\n");

			while (rs.next()) {
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					System.out.print(rs.getString(i) + "\t");
				}
				System.out.print("\n");
			}
			MoreResultSets = cs.getMoreResults();
		}
	}

	private void gregsChanges(Connection myConnection) throws SQLException {
		Statement stmt1 = myConnection.createStatement();
		stmt1.executeUpdate("set autocommit=0");
		Statement stmt2 = myConnection.createStatement();
		ResultSet results = stmt2
				.executeQuery("SELECT department_id, department_name "
						+ "                           FROM departments");
		while (results.next()) {
			int departmentID = results.getInt("department_id"); // Get column by
			// name
			String departmentName = results.getString(2); // Got column by
			// number
			System.out.println(departmentID + ":" + departmentName);
		}
		results.close();
		Statement stmt3 = myConnection.createStatement();
		ResultSet results2 = stmt2.executeQuery("SELECT *"
				+ "                           FROM departments");
		ResultSetMetaData meta1 = results2.getMetaData();

		for (int i = 1; i <= meta1.getColumnCount(); i++) {
			System.out.println("Column " + i + " " + meta1.getColumnName(i)
					+ " (" + meta1.getColumnTypeName(i) + ")");
		}

		PreparedStatement prepared1 = myConnection
				.prepareStatement("select product_id,product_description,normal_value"
						+ "  from products " + " where product_id=?");
		prepared1.setInt(1, 12);
		ResultSet pstmtResults1 = prepared1.executeQuery();
		while (pstmtResults1.next()) {
			System.out.println("Product Description: "
					+ pstmtResults1.getString(2));
		}
		pstmtResults1.close();

		for (int i = 1; i <= 10; i++) {
			prepared1.setInt(1, i);
			pstmtResults1 = prepared1.executeQuery();
			pstmtResults1.next();
			System.out.println("Product ID: " + i + "  Product Description: "
					+ pstmtResults1.getString(2));
		}
		pstmtResults1.close();

		myConnection.setAutoCommit(false);
		/* transactional statements go in here */
		myConnection.commit();

	}

	private void createDemoTables(Connection myConnection) throws SQLException {
		Statement s1 = myConnection.createStatement();
		s1.executeUpdate("CREATE TABLE DEMO " + "			(MyInt INT, "
				+ "		     MyString VARCHAR(30))");
	}

	private void createDemoTables2(Connection myConnection) {
		try {
			Statement s1 = myConnection.createStatement();
			s1.executeUpdate("CREATE TABLE DEMO" + "			(MyInt INT,"
					+ "		     MyString VARCHAR(30))");
		} catch (SQLException exception) {
			System.out.println("Error while creating demo tables: "
					+ exception.getErrorCode() + " SQLSTATE:"
					+ exception.getSQLState());
			exception.printStackTrace();
		}
	}

	private void executeProcedure(Connection connection, String sqlText)
			throws SQLException {
		CallableStatement cs = connection.prepareCall("{CALL " + sqlText + "}");
		boolean moreResultSets = cs.execute();
		while (moreResultSets) {
			ResultSet rs = cs.getResultSet();
			ResultSetMetaData rsmd = rs.getMetaData();

			StringBuffer buffer = new StringBuffer();
			for (int i = 1; i <= rsmd.getColumnCount(); i++)
				buffer.append(rsmd.getColumnName(i)).append("\t");
			System.out.println(buffer.toString());

			while (rs.next()) {
				buffer.setLength(0);
				for (int i = 1; i <= rsmd.getColumnCount(); i++)
					buffer.append(rs.getString(i)).append("\t");
				System.out.println(buffer.toString());
			}

			moreResultSets = cs.getMoreResults();
		}
	}
	
	private void guyrowset(Connection myConnection) throws SQLException {
		CachedRowSetImpl crs = new CachedRowSetImpl();
		
	}

	private void gregsCallable(Connection myConnection) throws SQLException {
		String schemaName = "prod";
		CallableStatement callableStmt = myConnection
				.prepareCall("{CALL sp_test_inout_rs2(?,?)}");
		callableStmt.registerOutParameter(2, Types.INTEGER);
		callableStmt.setString(1, schemaName);
		callableStmt.execute();
		boolean hasResults = callableStmt.execute();
		ResultSet rs1 = callableStmt.getResultSet();
		while (rs1.next())
			System.out.println(rs1.getString("table_name") + " "
					+ rs1.getString("table_type"));
		if (callableStmt.getMoreResults()) {
			ResultSet rs2 = callableStmt.getResultSet();
			while (rs2.next())
				System.out.println(rs2.getString(1) + " " + rs2.getString(2));
			rs2.close();
		}
		System.out.println("Out parameter = " + callableStmt.getInt(2)); 

		CallableStatement noResultStmt = myConnection
				.prepareCall("{call sp_noresult()}");
		noResultStmt.executeUpdate();

	}

	public static void main(String[] args) throws ClassNotFoundException,
			InstantiationException, IllegalAccessException {
		/*
		 * userName = args[0]; String passWord = args[1]; String hostName =
		 * args[2]; String dataBase = args[3]; String port = args[4]; String
		 * mySchema = args[5];
		 */

		try {
			/* Connect to MySQL */
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			Connection myConnection = DriverManager
					.getConnection("jdbc:mysql://localhost:3306/prod?user=root&password=secret");

			/*
			 * String connString = "jdbc:mysql://" + hostName + ":" + port + "/" +
			 * dataBase + "?user=" + userName + "&password=" + passWord;
			 * 
			 * Connection myConnect = DriverManager.getConnection(connString);
			 */

			System.out.println("Connected");

			Jdbc_example j = new Jdbc_example();
			//j.executeProcedure(myConnection,"sp_emps_in_dept(1)"); 
			j.gregsCallable(myConnection);
			// j.createDemoTables2(myConnection);
			// j.gregsChanges(myConnection);
			// j.empsInDept(myConnect,1);

			// qcache_test(myConnect);
			// callable_statement_test(myConnect);
			// outparameter(myConnect);
			// dynamic_proc(myConnect, "sp_2rs()");
			// outparameter(myConnect);
			/*
			 * int iterations=10000; long s1=System.currentTimeMillis();
			 * System.out.print("prepare1\n"); prepare1(myConnect,iterations);
			 * long s2=System.currentTimeMillis(); System.out.print("prepare
			 * many\n"); preparemany(myConnect,iterations); long
			 * s3=System.currentTimeMillis();
			 * System.out.print("PrepareOnec:"+(s2-s1)+"\n");
			 * System.out.print("PrepareMany:"+(s3-s2)+"\n");
			 */

		} catch (SQLException SQLEx) {
			System.out.println("MySQL error: " + SQLEx.getErrorCode()
					+ " SQLSTATE:" + SQLEx.getSQLState());
			System.out.println(SQLEx.getMessage());
			SQLEx.printStackTrace();
		}

	}

	static void qcache_test(Connection myConnect) throws SQLException {
		PreparedStatement qc = myConnect
				.prepareStatement("SHOW STATUS LIKE '%qcache%'");
		Statement s = myConnect.createStatement();
		ResultSet qcRs = qc.executeQuery();
		while (qcRs.next()) {
			System.out.println(qcRs.getString(1) + ":" + qcRs.getInt(2));
		}
		qcRs.close();

		for (int i = 0; i < 100; i++) {
			ResultSet r = s
					.executeQuery("SELECT sql_cache  employee_id FROM employees "
							+ " WHERE employee_id=1;");
			while (r.next()) {
			}
			r.close();
		}

		System.out.println("--------------------------------------------");
		qcRs = qc.executeQuery();
		while (qcRs.next()) {
			System.out.println(qcRs.getString(1) + ":" + qcRs.getInt(2));
		}
		qcRs.close();
	}

	static public void prepare1(Connection myConnect, int iterations)
			throws SQLException {
		CallableStatement cs = myConnect.prepareCall("{CALL donothing()}");
		// int i;
		for (int i = 1; i < iterations; i++)
			cs.execute();

	}

	static public void preparemany(Connection myConnect, int iterations)
			throws SQLException {

		// int i;
		for (int i = 1; i < iterations; i++) {
			CallableStatement cs = myConnect.prepareCall("{CALL donothing()}");
			cs.execute();
		}

	}

	static public void create_demo_tables(Connection myConnect) {
		try {
			Statement s1 = myConnect.createStatement();
			s1.executeUpdate("CREATE TABLE DEMO" + "			(MyInt INT,"
					+ "		     MyString VARCHAR(30))");
		} catch (SQLException SQLEx) {
			System.out
					.println("Error while creating demo tables: "
							+ SQLEx.getErrorCode() + " SQLSTATE:"
							+ SQLEx.getSQLState());
			System.out.println(SQLEx.getMessage());
			System.out.println(SQLEx.getStackTrace());
			// SQLEx.printStackTrace();
			// SQLEx.wait()

		}
	}

	static public void outparameter(Connection myConnect) throws SQLException {

		CallableStatement preparedProc = myConnect
				.prepareCall("{call updateEvent(?,?,?,?)}");

		preparedProc.registerOutParameter(1, Types.BIGINT);
		ParameterMetaData pmd = preparedProc.getParameterMetaData();
		int pc = pmd.getParameterCount();
		System.out.println(pmd.getParameterMode(1));
		for (int i = 1; i <= pc; i++) {
			System.out.print("Parm " + i + " Mode " + pmd.getParameterMode(i)
					+ "\t");
		}
		preparedProc.setString(2, "Updated by jdbc_example");
		Date d = new Date();
		preparedProc.setString(3, "2006-01-01");
		preparedProc.setInt(4, 10);
		boolean hasResults = preparedProc.execute();
		int rc = preparedProc.getInt(1);
		System.out.println(rc + " rows updated");
	}

	static public void callable_statement_test(Connection myConnect) {

		int aNumber = 4;
		try {
			CallableStatement preparedFunc = myConnect
					.prepareCall("{ ? = call isodd( ? ) }");
			preparedFunc.registerOutParameter(1, Types.INTEGER);

			preparedFunc.setInt(1, aNumber);
			preparedFunc.execute();

			ResultSetMetaData RsMd = preparedFunc.getMetaData();
			for (int i = 1; i <= RsMd.getColumnCount(); i++) {
				System.out.print(RsMd.getColumnName(i) + "\t");
			}

			ParameterMetaData pmd = preparedFunc.getParameterMetaData();
			for (int i = 1; i <= pmd.getParameterCount(); i++) {
				System.out.print(pmd.getParameterMode(i) + "\t");
			}

			if (preparedFunc.getInt(1) == 1)
				System.out.println(aNumber + " is odd");
			else
				System.out.println(aNumber + " is even");
		} catch (SQLException SQLEx) {
			System.out.println("Error executing: " + SQLEx.getErrorCode()
					+ " SQLSTATE:" + SQLEx.getSQLState());
			System.out.println(SQLEx.getMessage());
			// SQLEx.printStackTrace();

		}

	}

	static public void other_examples(Connection myConnect, String MySchema)
			throws SQLException {
		Statement stmt1 = myConnect.createStatement();
		stmt1.executeUpdate("set autocommit=1");

		Statement stmt2 = myConnect.createStatement();
		ResultSet results = stmt2
				.executeQuery("SELECT department_id, department_name "
						+ "                           FROM departments");

		while (results.next()) {
			int department_id = results.getInt("department_id"); /*
																	 * Get
																	 * column by
																	 * name
																	 */
			String department_name = results.getString(2); /*
															 * Got column by
															 * number
															 */
			System.out.println(department_id + ":" + department_name);
		}
		results.close();

		Statement stmt3 = myConnect.createStatement();
		ResultSet results2 = stmt2.executeQuery("SELECT *"
				+ "                           FROM departments");
		ResultSetMetaData meta1 = results2.getMetaData();

		for (int i = 1; i <= meta1.getColumnCount(); i++) {
			System.out.println("Column " + i + " " + meta1.getColumnName(i)
					+ " (" + meta1.getColumnTypeName(i) + ")");

		}

		PreparedStatement prepared1 = myConnect
				.prepareStatement("select product_id,product_description,normal_value"
						+ "  from products " + " where product_id=?");
		prepared1.setInt(1, 12);
		ResultSet pstmt1_results = prepared1.executeQuery();
		while (pstmt1_results.next()) {
			System.out.println("Product Description: "
					+ pstmt1_results.getString(2));
		}
		pstmt1_results.close();

		for (int i = 1; i <= 10; i++) {
			prepared1.setInt(1, i);
			pstmt1_results = prepared1.executeQuery();
			pstmt1_results.next();
			System.out.println("Product ID:" + i + "Product Description: "
					+ pstmt1_results.getString(2));
		}
		pstmt1_results.close();

		myConnect.setAutoCommit(false);
		/* transactional statement go in here */
		myConnect.commit();

		/* Create a callable statement for the stored procedure */
		CallableStatement preparedProc = myConnect
				.prepareCall("{CALL sp_test_inout_rs2(?,?)}");
		preparedProc.registerOutParameter(2, Types.INTEGER);

		/* A single execution of the stored procedure */
		/* Set the input parameter */
		preparedProc.setString(1, MySchema);

		boolean hasResults = preparedProc.execute();

		ResultSetMetaData rsmd = preparedProc.getMetaData();

		CallableStatement NoRSProc = myConnect
				.prepareCall("{call sp_noresult()");
		NoRSProc.executeUpdate();

		/* Process first result set */
		ResultSet rs1 = preparedProc.getResultSet();
		while (rs1.next()) {
			System.out.println(rs1.getString("table_name") + " "
					+ rs1.getString("table_type"));
		}

		/* process second result set */
		if (preparedProc.getMoreResults()) {
			ResultSet rs2 = preparedProc.getResultSet();
			while (rs2.next()) {
				System.out.println(rs2.getString(1) + " " + rs2.getString(2));
			}
			rs2.close();
		}
		/* Get the second output parameter */
		System.out.println("Out parameter =" + preparedProc.getInt(2));

		create_demo_tables(myConnect);

	}
}
