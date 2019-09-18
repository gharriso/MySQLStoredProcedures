SELECT count(*) 
  FROM customers  
 WHERE EXISTS (SELECT 'anything'                  
                 FROM employees                  
                WHERE surname=customers.contact_surname                   
                  AND firstname=customers.contact_firstname                          
                  AND date_of_birth=customers.date_of_birth)
