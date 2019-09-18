CREATE PROCEDURE `emps_in_dept2`(in_dept_id VARCHAR(1000))
BEGIN
  SET @sql=CONCAT(
      "SELECT employee_id,firstname,surname
         FROM employees
        WHERE department_id=",in_dept_id);
   PREPARE s1 FROM @sql;   
   EXECUTE s1;
   DEALLOCATE PREPARE s1;
END;
