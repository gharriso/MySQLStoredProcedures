IF (sale_value>200) THEN
	CALL free_shipping(sale_id);
ELSEIF (sale_value >200 AND customer_status='PREFERRED') THEN
	CALL free_shipping(sale_id);
	CALL apply_discount(sale_id,20);
END IF;
