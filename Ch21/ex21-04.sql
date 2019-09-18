SELECT COUNT(*), SUM(sales.quantity), SUM(sales.sale_value)
  FROM sales   
  JOIN customers ON (sales.customer_id=customers.customer_id)
  JOIN employees ON (sales.sales_rep_id=employees.employee_id)
  JOIN products  ON (sales.product_id=products.product_id)
 WHERE customers.customer_name='INVITRO INTERNATIONAL'
   AND employees.surname='GRIGSBY'
   AND employees.firstname='RAY'
   AND products.product_description='SLX';
