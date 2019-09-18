CallableStatement PreparedFunc = 
	MyConnect.prepareCall("{ ? = call isodd( ? ) }");
PreparedFunc.registerOutParameter(1, Types.INTEGER);

PreparedFunc.setInt(1, aNumber); 
PreparedFunc.execute();

if (PreparedFunc.getInt(1) == 1)
	System.out.println(aNumber + " is odd");
else
	System.out.println(aNumber + " is even");
