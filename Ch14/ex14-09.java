PreparedStatement prepared1 = myConnection.prepareStatement(
					"select product_id,product_description,normal_value" +
					"  from products " +
					" where product_id=?");		
prepared1.setInt(1, 12);
ResultSet pstmtResults1 = prepared1.executeQuery();
while (pstmtResults1.next())
{
	System.out.println("Product Description: " + pstmtResults1.getString(2));
}
pstmtResults1.close(); 
