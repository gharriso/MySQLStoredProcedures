 CREATE PROCEDURE stored_proc_with_2_results(in_sales_rep_id INT)
	DETERMINISTIC READS SQL DATA
BEGIN
	
	 SELECT employee_id,surname,firstname 
	   FROM employees 
	  WHERE employee_id=in_sales_rep_id;
		
	 SELECT customer_id,customer_name 
       FROM customers
	  WHERE sales_rep_id=in_sales_rep_id; 
	 
END;
