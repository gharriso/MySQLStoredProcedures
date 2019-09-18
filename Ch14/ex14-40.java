	private class MyStoredProcedure extends StoredProcedure
 	{
		public MyStoredProcedure(DataSource ds)
 		{
			setDataSource(ds);
			setSql("sp_department_report");

			declareParameter(new SqlReturnResultSet("Employees",
					new RowMapper() {
						public Object mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							Employee e = new Employee(
									rs.getInt("employee_id"),
									rs.getString("surname"), 
									rs.getString("firstname"), 
									rs.getString("address1"), 
									rs.getString("address2"), 
									rs.getDouble("salary"));
							return e;
						}
					}));
			
			declareParameter(new SqlReturnResultSet("Customers",
					new RowMapper() {
						public Object mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							Customer c = new Customer(
									rs.getInt("customer_id"),
									rs.getString("customer_name"), 
									rs.getString("address1"), 
									rs.getString("address2"), 
									rs.getString("zipcode"));
							return c;
						}
					}));

			declareParameter(new SqlParameter("department_id", Types.INTEGER));

			declareParameter(new SqlOutParameter("sales_total", Types.DOUBLE));

			compile();
		}

	}
