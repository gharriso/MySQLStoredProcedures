SELECT cust_status(customer_status) as Status, count(*) as Count
  FROM customers
 GROUP BY customer_status
 ORDER BY cust_status(customer_status);
