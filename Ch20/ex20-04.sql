SELECT * 
  FROM customers 
 WHERE date_of_birth < DATE_SUB(curdate(),interval 55 year)
