SELECT count(*), SUM(quantity)    
  FROM sales  
 WHERE customer_id=77    
   AND product_id=90    
   AND sales_rep_id=61
