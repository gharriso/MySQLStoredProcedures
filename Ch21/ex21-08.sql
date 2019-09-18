SELECT count(*) 
  FROM customers   
 WHERE NOT EXISTS (SELECT *  	   
                     FROM employees  	  
                    WHERE surname=customers.contact_surname  	    
                      AND firstname=customers.contact_firstname  	    
                      AND date_of_birth=customers.date_of_birth) 
