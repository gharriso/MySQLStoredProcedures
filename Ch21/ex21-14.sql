SELECT  SUM(quantity),SUM(sale_value)   
  FROM v_sales_2004_merge  
 WHERE customer_id=1    
   AND product_id=1;
