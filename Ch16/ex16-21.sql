CREATE PROCEDURE sp_rep_report(in_sales_rep_id int)
	READS SQL DATA
BEGIN
	
	 SELECT employee_id,surname,firstname 
	   FROM employees 
	  WHERE employee_id=in_sales_rep_id;
		
	 SELECT customer_id,customer_name 
       FROM customers
	  WHERE sales_rep_id=in_sales_rep_id; 
	 
END;
