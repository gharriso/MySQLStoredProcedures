
CREATE PROCEDURE get_customer_details(in_customer_id INT)
BEGIN
	DECLARE l_customer_name     VARCHAR(30);
	DECLARE l_contact_surname   VARCHAR(30);
	DECLARE l_contact_firstname VARCHAR(30);
	
	SELECT customer_name, contact_surname,contact_firstname 
	  INTO l_customer_name,l_contact_surname,l_contact_firstname
	  FROM customers
	 WHERE customer_id=in_customer_id;
	 
	/* Do something with the customer record */ 

END;

