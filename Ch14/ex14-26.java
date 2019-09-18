public int ejbFindByPhoneNo(String phoneNo) throws FinderException
{
	try {
		Connection connection = getConnection();
		PreparedStatement statement = connection.prepareStatement
			("SELECT customer_id FROM customers WHERE phoneno=?");
		statement.setString(1, phoneNo);
		ResultSet resultSet = statement.executeQuery();
		if (!resultSet.next())
		{
			statement.close();
			connection.close();
			throw new FinderException("Could not find: " + phoneNo);
		}
		statement.close();
		connection.close();
		return resultSet.getInt(1);
	}
	catch(SQLException e) {
		throw new EJBException ("Could not find: " + phoneNo, e);
	}
}
