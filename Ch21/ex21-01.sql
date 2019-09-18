SELECT count(*) 
  FROM customers   
 WHERE (contact_surname, contact_firstname,date_of_birth)        
    IN (select surname,firstname,date_of_birth           
          FROM employees) 
