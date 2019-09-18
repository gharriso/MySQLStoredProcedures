CREATE PROCEDURE sp_cust_list2 (in_sales_rep_id INT)
	 SQL SECURITY INVOKER
BEGIN
	 DECLARE denied INT DEFAULT 0;
	
	 DECLARE command_denied CONDITION FOR 1142;
	 DECLARE CONTINUE HANDLER FOR command_denied SET denied=1;
	
	 SELECT customer_id, customer_name	
	   FROM customers
	  WHERE sales_rep_id=14;
	
	 IF denied =1 THEN 
		  SELECT 'You may not view customer data.'
			 AS 'Permission Denied';
	 END IF;
END;
