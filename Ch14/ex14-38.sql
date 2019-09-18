CREATE PROCEDURE sp_department_report
  (in_dept_id INTEGER, OUT sales_total DECIMAL(8,2))
BEGIN

  SELECT employee_id, surname, firstname, address1, address2, salary
    FROM employees
   WHERE department_id = in_dept_id;

  SELECT customer_id, customer_name, address1, address2, zipcode
    FROM customers
   WHERE sales_rep_id IN
      (SELECT employee_id FROM employees
        WHERE department_id = in_dept_id);

   SELECT SUM(sale_value)
     INTO sales_total
     FROM sales
    WHERE customer_id IN
        (SELECT customer_id
           FROM customers
          WHERE sales_rep_id IN
              (SELECT employee_id
                  FROM employees
                 WHERE department_id = in_dept_id));
END
