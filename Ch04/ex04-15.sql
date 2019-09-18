
CASE customer_status
	WHEN 'PLATINUM'  THEN 
		CALL apply_discount(sale_id,20); /* 20% discount */ 
			 
	WHEN 'GOLD' THEN  
		CALL apply_discount(sale_id,15); /* 15% discount */ 
		 
	WHEN 'SILVER' THEN  
		CALL apply_discount(sale_id,10); /* 10% discount */ 

	WHEN 'BRONZE' THEN 	
		CALL apply_discount(sale_id,5); /* 5% discount*/ 
END CASE;
