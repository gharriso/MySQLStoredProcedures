	private void empsInDept(Connection myConnect, int deptId) throws SQLException {
		
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
