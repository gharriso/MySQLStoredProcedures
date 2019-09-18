CREATE PROCEDURE needy_bonus()
  DETERMINISTIC
BEGIN
  DECLARE  v_employee_id INT;
  DECLARE  v_salary      NUMERIC(8,2);
  DECLARE  v_last_emp    INT DEFAULT 0;

  DECLARE emp_csr CURSOR FOR
   SELECT employee_id,salary
     FROM employees
    WHERE salary <45000
      FOR UPDATE;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET  v_last_emp=1;

  START TRANSACTION;
    OPEN emp_csr;
    emp_loop:LOOP
      FETCH emp_csr INTO  v_employee_id, v_salary;
      IF  v_last_emp THEN
        LEAVE emp_loop;
      END IF;
      CALL grant_raise( v_employee_id, v_salary);
    END LOOP emp_loop;
    CLOSE emp_csr;
    SET  v_last_emp=0;

  COMMIT;

END;
