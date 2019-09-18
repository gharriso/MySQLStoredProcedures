CREATE PROCEDURE using_into
       ( p_customer_id int,out p_customer_name varchar(30))
	READS SQL DATA
BEGIN
		SELECT customer_name 
		  INTO p_customer_name
		  FROM customers
		 WHERE customer_id=p_customer_id;
END;

CREATE PROCEDURE using_cursor
	(p_customer_id INT,OUT  p_customer_name VARCHAR(30))
	READS SQL DATA
BEGIN
	
	DECLARE cust_csr CURSOR FOR 
		SELECT customer_name 
		  FROM customers
		 WHERE customer_id=p_customer_id;
		
		OPEN cust_csr;
		FETCH cust_csr INTO p_customer_name;
		CLOSE cust_csr;

END;
