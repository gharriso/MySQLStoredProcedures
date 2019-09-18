CREATE PROCEDURE sp_max_sale_by_cust()
	MODIFIES SQL DATA
BEGIN
	DECLARE last_sale INT DEFAULT 0;
	DECLARE l_last_customer_id INT DEFAULT -1; 
	DECLARE l_customer_id INT;
	DECLARE l_product_id INT;
	DECLARE l_quantity INT;
	DECLARE l_sale_value DECIMAL(8,2);
	DECLARE counter INT DEFAULT 0;
	
	
	DECLARE sales_csr CURSOR FOR
		SELECT customer_id,product_id,quantity, sale_value 
		  FROM sales
		 WHERE sale_date>date_sub(currdate(),interval 6 month)	
		 ORDER BY customer_id,sale_value DESC;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET last_sale=1;
	
	OPEN sales_csr;
	sales_loop: LOOP
		FETCH sales_csr INTO l_customer_id,l_product_id,l_quantity,l_sale_value;
		IF (last_sale=1) THEN 
		    LEAVE sales_loop; 
		END IF;
		
		IF l_customer_id <> l_last_customer_id THEN 
		   /* This is a new customer so first row will be max sale*/
			 INSERT INTO max_sales_by_customer
			    (customer_id,product_id,quantity,sale_value)
				VALUES(l_customer_id,l_product_id,l_quantity,l_sale_value);
		END IF;
		
		SET l_last_customer_id=l_customer_id;
		
		
	END LOOP;
	
end;
