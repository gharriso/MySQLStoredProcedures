SELECT SUM(quantity),SUM(sale_value)   
  from (SELECT * 
          FROM sales           
         WHERE sale_date BETWEEN '2004-01-01' AND '2004-12-31') sales  
 WHERE customer_id=1    
   AND product_id=1;
