try {
   Class.forName("com.mysql.jdbc.Driver").newInstance();

   String ConnectionString="jdbc:mysql://" + hostname + "/" + database + "?user=" +
          username + "&password=" + password;
   System.out.println(ConnectionString);
   Connection conn = DriverManager.getConnection(ConnectionString);
   Statement stmt=conn.createStatement();
   stmt.execute("call error_test_proc(1)");
}
catch(SQLException SQLEx) {
   System.out.println("MySQL error: "+SQLEx.getErrorCode()+
          " SQLSTATE:" +SQLEx.getSQLState());
   System.out.println(SQLEx.getMessage());
}
