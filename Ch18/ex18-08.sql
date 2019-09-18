CREATE PROCEDURE sp_cust_list (in_sales_rep_id INT)
	 SQL SECURITY INVOKER
BEGIN
	 SELECT customer_id, customer_name	
	   FROM customers
	  WHERE sales_rep_id=in_sales_rep_id;
END;
