

DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_last_customer=1;
	
SET l_last_customer=0;        
OPEN customer_csr;
cust_loop:LOOP		/* Loop through overdue customers*/
		
	FETCH customer_csr INTO l_customer_id; 
	IF l_last_customer=1 THEN LEAVE cust_loop; END IF; /*no more rows*/
	SET l_customer_count=l_customer_count+1;
		
	sales_block: BEGIN
		DECLARE l_last_sale INT DEFAULT 0;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_last_sale=1;
		OPEN  sales_csr;		
		sales_loop:LOOP    /* Get all sales for the customer */
		
			FETCH sales_csr INTO l_sales_id;
			IF l_last_sale=1 THEN LEAVE sales_loop; END IF; /*no more rows*/
			
			CALL check_sale(l_sales_id);  /* Check the sale status */
			SET l_sales_count=l_sales_count+1;
			
		END LOOP sales_loop;
		SET l_last_sale=0;
		CLOSE sales_csr;
	END sales_block;
		
END LOOP cust_loop; 
SET l_last_customer=0;        
CLOSE customer_csr;
