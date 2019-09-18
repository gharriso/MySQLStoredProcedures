if (callableStmt.getMoreResults())
{
    ResultSet rs2 = callableStmt.getResultSet();
    while (rs2.next())
         System.out.println(rs2.getString(1) + " " + rs2.getString(2));
    rs2.close();
}
