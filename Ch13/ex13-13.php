CREATE PROCEDURE customers_for_rep(in_sales_rep_id INT)
	READS SQL DATA 
	 SELECT customer_id,customer_name
	   FROM customers
		WHERE sales_rep_id=in_sales_rep_id;
