CREATE PROCEDURE sp_employee_report(in_emp_id decimal(8,0))
	READS SQL DATA
BEGIN
	DECLARE customer_count INT;
	
	SELECT surname,firstname,date_of_birth
	  FROM employees
	 WHERE employee_id=in_emp_id;
	 
	SELECT department_id,department_name
	  FROM departments 
	 WHERE department_id=
	       (select department_id
	          FROM employees
	         WHERE employee_id=in_emp_id); 
	         
	SELECT count(*)
	  INTO customer_count
	  FROM customers
	 WHERE sales_rep_id=in_emp_id;         
	 
	IF customer_count=0 THEN
		SELECT 'Employee is not a current sales rep';
	ELSE
		SELECT customer_name,customer_status
		  FROM customers
		 WHERE sales_rep_id=in_emp_id;
		 
		SELECT customer_name,sum(sale_value)
		  FROM sales JOIN customers USING (customer_id) 
		 WHERE customers.sales_rep_id=in_emp_id
		 GROUP BY customer_name;
	END IF; 
	
END;
