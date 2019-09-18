CREATE PROCEDURE sp_overdue_sales ()
  
BEGIN
  DROP TEMPORARY TABLE IF EXISTS overdue_sales_tmp;
  CREATE TEMPORARY TABLE overdue_sales_tmp AS
  SELECT sales_id,customer_id,sale_date,quantity,sale_value
    FROM sales
   WHERE sale_status='O';

END;
