CREATE PROCEDURE emps_in_dept(in_dept_id int) 
       READS SQL DATA
BEGIN
    SELECT employee_id,firstname,surname
      FROM employees
     WHERE department_id=in_dept_id;
END;
