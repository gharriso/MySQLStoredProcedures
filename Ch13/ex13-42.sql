CREATE PROCEDURE `sp_rep_customer_count`(
       in_emp_id DECIMAL(8,0),
       OUT out_cust_count INT)
    READS SQL DATA
BEGIN
             
  SELECT count(*) AS cust_count
    INTO out_cust_count  
    FROM customers
   WHERE sales_rep_id=in_emp_id;

END ;
