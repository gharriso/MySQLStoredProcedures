
	IF (sale_value >200 AND customer_status='PLATINUM') THEN 
		CALL free_shipping(sale_id); 	 /* Free shipping*/
		CALL apply_discount(sale_id,20); /* 20% discount */
		
	ELSEIF (sale_value >200 AND customer_status='GOLD') THEN 
		CALL free_shipping(sale_id); 	 /* Free shipping*/
		CALL apply_discount(sale_id,15); /* 15% discount */
		
	ELSEIF (sale_value >200 AND customer_status='SILVER') THEN 
		CALL free_shipping(sale_id);     /* Free shipping*/ 
		CALL apply_discount(sale_id,10); /* 10% discount */
		
	ELSEIF (sale_value >200 AND customer_status='BRONZE') THEN 
		CALL free_shipping(sale_id);    /* Free shipping*/
		CALL apply_discount(sale_id,5); /* 5% discount*/
				
	ELSEIF (sale_value>200) 	THEN 
		CALL free_shipping(sale_id);    /* Free shipping*/
		 
	END IF;
