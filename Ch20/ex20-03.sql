SELECT * 
  FROM customers 
 WHERE (DATEDIFF(curdate(),date_of_birth)/365.25) >55
