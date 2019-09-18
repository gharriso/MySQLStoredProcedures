CREATE PROCEDURE sp_customer_search
    (in_customer_name VARCHAR(30),
     in_contact_surname VARCHAR(30),
     in_contact_firstname VARCHAR(30),
     in_phoneno VARCHAR(10))
  
BEGIN
  SELECT *
    FROM customers
   WHERE (customer_name LIKE in_customer_name
          OR in_customer_name IS NULL)
     AND (contact_surname LIKE in_contact_surname
          OR in_contact_surname IS NULL)
     AND (contact_firstname LIKE in_contact_firstname
          OR in_contact_firstname IS NULL)
     AND (phoneno LIKE in_phoneno
          OR in_phoneno IS NULL) ;

END;
