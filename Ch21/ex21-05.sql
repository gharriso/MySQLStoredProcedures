SELECT COUNT(*), SUM(sales.quantity), SUM(sales.sale_value) 
  FROM sales 
 WHERE product_id= (SELECT product_id 
                      FROM products
                      WHERE product_description='SLX')
   AND sales_rep_id=(SELECT employee_id 
                       FROM employees 
                      WHERE surname='GRIGSBY'
                        AND firstname='RAY')
   AND customer_id= (SELECT customer_id 
                       FROM customers 
                      WHERE customer_name='INVITRO INTERNATIONAL');
