SELECT SUM(quantity),SUM(sale_value)   
  FROM sales  
 WHERE sale_date BETWEEN '2004-01-01' and '2004-12-31'    
   AND customer_id=1    
   AND product_id=1
