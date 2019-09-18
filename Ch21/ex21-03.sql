select count(*)    
  FROM customers JOIN employees     
    ON (employees.surname=customers.contact_surname         
        AND employees.firstname=customers.contact_firstname         
        AND employees.date_of_birth=customers.date_of_birth)  
