CREATE PROCEDURE sp_employee_report
    (in_emp_id INTEGER,
     OUT out_customer_count INTEGER)
BEGIN

  SELECT employee_id,surname,firstname,date_of_birth
    FROM employees
   WHERE employee_id=in_emp_id;

  SELECT department_id,department_name
    FROM departments
   WHERE department_id=
         (select department_id
            FROM employees  
           WHERE employee_id=in_emp_id);

  SELECT COUNT(*)
    INTO out_customer_count
    FROM customers
   WHERE sales_rep_id=in_emp_id;

  IF out_customer_count=0 THEN
    SELECT 'Employee is not a current sales rep';
  ELSE
    SELECT customer_name,customer_status
      FROM customers
     WHERE sales_rep_id=in_emp_id;

    SELECT customer_name,SUM(sale_value) as "TOTAL SALES",
           MAX(sale_value) as "MAX SALE"
      FROM sales JOIN customers USING (customer_id)
     WHERE customers.sales_rep_id=in_emp_id
     GROUP BY customer_name;
  END IF;
END
