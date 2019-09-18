
	IF (sale_value > 200) THEN 
		CALL free_shipping(sale_id);    /*Free shipping*/

		IF (customer_status='PLATINUM') THEN
			CALL apply_discount(sale_id,20); /* 20% discount */
			
		ELSEIF (customer_status='GOLD') THEN 
			CALL apply_discount(sale_id,15); /* 15% discount */
		
		ELSEIF (customer_status='SILVER') THEN 
			CALL apply_discount(sale_id,10); /* 10% discount */
		
		ELSEIF (customer_status='BRONZE') THEN 
			CALL apply_discount(sale_id,5); /* 5% discount*/
		END IF;

	END IF;
