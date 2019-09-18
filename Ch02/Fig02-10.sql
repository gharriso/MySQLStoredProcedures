DROP PROCEDURE IF EXISTS customer_sales
$$
CREATE PROCEDURE customer_sales
        (in_customer_id INT)
   READS SQL DATA
BEGIN
    DECLARE total_sales NUMERIC(8,2);

    SELECT SUM(sale_value)
      INTO total_sales
      FROM sales
     WHERE customer_id=in_customer_id;

    SELECT CONCAT('Total sales for ',in_customer_id,' is ',total_sales);
END;
$$