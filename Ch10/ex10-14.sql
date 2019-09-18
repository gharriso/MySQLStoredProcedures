CREATE FUNCTION customers_for_rep(in_rep_id INT)
	RETURNS INT 
	READS SQL DATA
BEGIN
	DECLARE customer_count INT;
	
	SELECT COUNT(*)
		INTO customer_count
	  FROM customers
	 WHERE sales_rep_id=in_rep_id;
	
	RETURN(customer_count);
	
END;
