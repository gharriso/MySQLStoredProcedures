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
