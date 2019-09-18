SELECT count(*) 
  FROM customers   
 WHERE (contact_surname,contact_firstname, date_of_birth) 
    NOT IN    	(SELECT surname,firstname, date_of_birth   	   
                 FROM employees)
