
CREATE PROCEDURE cursor_demo (in_customer_id INT)
BEGIN
  DECLARE v_customer_id   INT;
  DECLARE v_customer_name VARCHAR(30);
  DECLARE c1 CURSOR FOR
      SELECT in_customer_id,customer_name
        FROM customers
       WHERE customer_id=in_customer_id; 
