
CREATE PROCEDURE bad_nested_cursors()
  READS SQL DATA
BEGIN

  DECLARE l_department_id INT;
  DECLARE l_employee_id   INT;
  DECLARE l_emp_count     INT DEFAULT 0 ;
  DECLARE l_done          INT DEFAULT  0;

  DECLARE dept_csr cursor  FOR
    SELECT department_id FROM departments;

  DECLARE emp_csr cursor  FOR
    SELECT employee_id FROM employees
     WHERE department_id=l_department_id;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_done=1;

  OPEN dept_csr;
  dept_loop: LOOP   -- Loop through departments
    FETCH dept_csr into l_department_id;

    IF l_done=1 THEN
       LEAVE dept_loop;
    END IF;

    OPEN emp_csr;
    SET l_emp_count=0;
    emp_loop: LOOP      -- Loop through employee in dept.
      FETCH emp_csr INTO l_employee_id;

      IF l_done=1 THEN
         LEAVE emp_loop;
      END IF;
      SET l_emp_count=l_emp_count+1;
    END LOOP;
    CLOSE emp_csr;

    SELECT CONCAT('Department ',l_department_id,' has ',
           l_emp_count,' employees');

  END LOOP dept_loop;
  CLOSE dept_csr;

END;
