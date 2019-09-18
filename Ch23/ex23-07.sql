CREATE FUNCTION cust_contact_name (in_customer_id INT)
  RETURNS VARCHAR(100)
  READS SQL DATA
BEGIN
  DECLARE  v_contact_name VARCHAR(100);

  SELECT CONCAT(contact_firstname,' ',contact_surname)
    INTO  v_contact_name
    FROM customers
   WHERE customer_id=in_customer_id ;

  RETURN( v_contact_name);

END$
