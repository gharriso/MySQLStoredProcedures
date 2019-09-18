for (int i = 1; i <= 10; i++)
{
	prepared1.setInt(1, i);
	pstmtResults1 = prepared1.executeQuery();
	pstmtResults1.next();
	System.out.println("Product ID: " + i +
    	"  Product Description: " + pstmtResults1.getString(2));
}
pstmtResults1.close();
