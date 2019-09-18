
IF sale_value > 200 THEN
	CALL apply_free_shipping(sale_id);
	IF sale_value > 500 THEN
		CALL apply_discount(sale_id,20);
	END IF;
END IF;

