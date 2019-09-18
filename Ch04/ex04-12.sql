
/* Re-ordering the IF conditions */
IF (sale_value >200 and customer_status='PREFERED') THEN
		CALL free_shipping(sale_id);
		CALL apply_discount(sale_id,20);
ELSEIF (sale_value>200) THEN
		CALL free_shipping(sale_id);
		
END IF;

/* Nesting the IF conditions */

IF (sale_value >200) THEN
	CALL free_shipping(sale_id);
	IF (customer_satus='PREFERRED') THEN
	   CALL apply_discount(sale_id,20);
	END IF;
END IF:
