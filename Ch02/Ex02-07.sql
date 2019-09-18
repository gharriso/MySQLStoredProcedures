CREATE PROCEDURE putting_it_all_together(in_department_id INT)
    DETERMINISTIC MODIFIES SQL DATA
BEGIN
    DECLARE l_employee_id INT;
    DECLARE l_salary      NUMERIC(8,2);
    DECLARE l_department_id INT;
    DECLARE l_new_salary  NUMERIC(8,2);
    DECLARE done          INT DEFAULT 0;

    DECLARE cur1 CURSOR FOR
            SELECT employee_id, salary, department_id
              FROM employees
             WHERE department_id=in_department_id
               FOR UPDATE ;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

    CREATE TEMPORARY TABLE IF NOT EXISTS emp_raises
      (employee_id INT, department_id INT, new_salary NUMERIC(8,2));

    OPEN cur1;
    emp_loop: LOOP

      FETCH cur1 INTO l_employee_id, l_salary, l_department_id;

      IF done=1 THEN       /* No more rows*/
         LEAVE emp_loop;
      END IF;

      CALL new_salary(l_employee_id,l_new_salary); /*get new salary*/

      IF (l_new_salary<>l_salary) THEN             /*Salary changed*/

         UPDATE employees
            SET salary=l_new_salary
          WHERE employee_id=l_employee_id;
         /* Keep track of changed salaries*/
         INSERT INTO emp_raises (employee_id,department_id,new_salary)
          VALUES (l_employee_id,l_department_id,l_new_salary);
      END IF;

    END LOOP emp_loop;
    CLOSE cur1;
    /* Print out the changed salaries*/
    SELECT employee_id,department_id,new_salary from emp_raises;
    COMMIT;
END;
