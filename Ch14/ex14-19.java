ResultSet rs1 = callableStmt.getResultSet();
while (rs1.next())
     System.out.println(rs1.getString("table_name") + " " +
					rs1.getString("table_type"));
