import java.sql.*;
import java.math.*;

public class SalesSummary {

	public static void main(String[] args)	       
		throws ClassNotFoundException, InstantiationException,
    			IllegalAccessException  {
		String Username=args[0];
		String Password=args[1];
		String Hostname=args[2];
		String Database=args[3];
		String Port=args[4];
		
        float SumSales,SumSquares,SaleValue,StdDev,Mean;
        int   NValues=0;
        
        SumSales=SumSquares=0;
        
    	try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String ConnString=
                "jdbc:mysql://"+Hostname+":"+Port+
				    "/"+Database+"?user="+Username+"&password="+Password;
			Connection MyConnect = DriverManager.getConnection(ConnString);
			
			String sql="select sale_value from SALES s" +
                         " where sale_date >date_sub(curdate(),interval 6 month)";
			
			Statement s1=MyConnect.createStatement();
			ResultSet rs1=s1.executeQuery(sql);
			while (rs1.next())
			{
				SaleValue = rs1.getFloat(1);
                NValues = NValues + 1;
                SumSales = SumSales + SaleValue;
                SumSquares = SumSquares + SaleValue*SaleValue;
			}
			rs1.close();
			
			Mean=SumSales/NValues;
			StdDev = (float) Math.sqrt(((SumSquares - 
					((SumSales*SumSales) / NValues)) / NValues));
			
			System.out.println("Mean="+Mean+" StdDev="+StdDev+" N="+NValues);
			
		}
		catch(SQLException Ex) 		{
			System.out.println(Ex.getErrorCode()+" "+Ex.getMessage());	
			Ex.printStackTrace();}
			
	}
}
