SELECT CASE customer_status 
            WHEN 'U' THEN 'Up to Date' 
            WHEN 'N' THEN 'New' 
            WHEN 'O' THEN 'Overdue'
       END  as Status, count(*) as Count
  FROM customers
 GROUP BY customer_status
 ORDER BY CASE customer_status 
            WHEN 'U' THEN 'Up to Date' 
            WHEN 'N' THEN 'New' 
            WHEN 'O' THEN 'Overdue'
       END 
