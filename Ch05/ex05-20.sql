

CREATE PROCEDURE emps_in_dept(in_department_id INT)
BEGIN
	SELECT department_name, location 
	  FROM departments 
	 WHERE department_id=in_department_id;
	 
	SELECT employee_id,surname,firstname
	  FROM employees
	 WHERE department_id=in_department_id; 
END;
