SELECT count(*)   
  FROM customers    
       LEFT JOIN employees 
         ON (customers.contact_surname=employees.surname 
             and customers.contact_firstname=employees.firstname 
             and customers.date_of_birth=employees.date_of_birth)  
  WHERE employees.surname IS NULL
