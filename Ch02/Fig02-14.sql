CREATE PROCEDURE sp_update_salary
	(in_employee_id INT, in_new_salary NUMERIC(8,2))
    DETERMINISTIC
BEGIN  
  	IF in_new_salary <5000 OR in_new_salary > 500000 THEN  
		SELECT 'Illegal salary; salary must be between $5,000 and $500,000';
	ELSE
		UPDATE employees
                        SET salary=in_new_salary
                 WHERE employee_id=in_employee_id;
	END IF;
END 