CREATE OR REPLACE VIEW v_sales_2004
       (sales_id,customer_id,product_id,sale_date, 
        quantity,sale_value,department_id,sales_rep_id,gst_flag) AS   
SELECT sales_id,customer_id,product_id,sale_date,
       quantity,sale_value,department_id,sales_rep_id,gst_flag   
  FROM sales   
 WHERE sale_date BETWEEN '2004-01-01' AND '2004-12-31'
