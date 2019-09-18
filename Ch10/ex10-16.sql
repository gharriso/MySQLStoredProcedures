SELECT employee_id,COUNT(*)
  FROM employees JOIN customers
	ON (employee_id=sales_rep_id)
 GROUP BY employee_id
 HAVING COUNT(*) > 10 
 ORDER BY COUNT(*) desc;
