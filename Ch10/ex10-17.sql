SELECT employee_id,customers_for_rep(employee_id) 
  FROM employees
 WHERE customers_for_rep(employee_id)>10
 ORDER BY customers_for_rep(employee_id) desc
