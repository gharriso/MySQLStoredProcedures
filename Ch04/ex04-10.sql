

IF sale_value <200 THEN
	CALL apply_shipping(sale_id);
ELSE 
	CALL apply_discount(sale_id);
END IF;
