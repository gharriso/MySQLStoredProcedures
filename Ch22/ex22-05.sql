SELECT s.customer_id,s.product_id,s.quantity, s.sale_value 
  FROM sales s, (SELECT customer_id,max(sale_value) max_sale_value
			     FROM sales
			    GROUP BY customer_id) t 
 WHERE t.customer_id=s.customer_id
   AND t.max_sale_value=s.sale_value
   AND s.sale_date>date_sub(currdate(),interval 6 month);
