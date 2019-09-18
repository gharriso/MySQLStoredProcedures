CREATE PROCEDURE sp_custsales
  (in_customer_id INT,
   OUT out_sales_total FLOAT)
BEGIN
	SELECT customer_name
	  FROM customers
	 WHERE customer_id=in_customer_id;

	SELECT sum(sale_value)
	  INTO out_sales_total
	  FROM sales
	 WHERE customer_id=in_customer_id;

END;
