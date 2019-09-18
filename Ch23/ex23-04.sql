CREATE FUNCTION department_name(in_dept_id INT) RETURNS VARCHAR(30)
  READS SQL DATA
BEGIN
  DECLARE  v_dept_name VARCHAR(30);

  DECLARE dept_csr CURSOR FOR
  SELECT department_name
    FROM departments
   WHERE department_id=in_dept_id;

   OPEN dept_csr;
   FETCH dept_csr INTO  v_dept_name;
   CLOSE dept_csr;

  RETURN  v_dept_name;
END;
