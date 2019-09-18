CREATE PROCEDURE sp_correlated_update()
	MODIFIES SQL DATA
BEGIN
	DECLARE last_customer INT DEFAULT 0;
	DECLARE l_customer_id INT ;
	DECLARE l_manager_id  INT;
	
	
	DECLARE cust_csr CURSOR FOR
          select c.customer_id,e.manager_id
            from customers c,
                 employees e
           where e.surname=c.contact_surname
             and e.firstname=c.contact_firstname
             and e.date_of_birth=c.date_of_birth;
						
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET last_customer=1;
					
						
	OPEN cust_csr;
	cust_loop: LOOP
			FETCH cust_csr INTO l_customer_id,l_manager_id;
			IF (last_customer=1) THEN 
				LEAVE cust_loop;
			END IF;
			UPDATE customers
         SET sales_rep_id=l_manager_id
       WHERE customer_id=l_customer_id;
	END LOOP;

END;

