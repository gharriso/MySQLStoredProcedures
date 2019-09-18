CREATE PROCEDURE customer_list(in_sales_rep_id INTEGER)
  SELECT customer_id,customer_name
    FROM customers
   WHERE sales_rep_id=in_sales_rep_id;
