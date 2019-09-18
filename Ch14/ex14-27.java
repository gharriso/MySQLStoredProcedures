public int ejbFindByPhoneNoSP(String phoneNo) throws FinderException
{
	try {
		Connection connection = getConnection();
		String sqlText = "{call getcustomeridbyphoneno(?,?,?)}";
			
		CallableStatement custStmt = connection.prepareCall(sqlText);
		custStmt.registerOutParameter(2, Types.INTEGER);
		custStmt.registerOutParameter(3, Types.INTEGER);
			
		custStmt.setString(1, phoneNo);
		custStmt.execute();
		if (custStmt.getInt(3) == 1) // Not Found indicator
			throw new FinderException("Could not find: " + phoneNo);

		return custStmt.getInt(2);
	}
	catch(SQLException e) {
		throw new EJBException("Could not find: " + phoneNo, e);
	}
}
