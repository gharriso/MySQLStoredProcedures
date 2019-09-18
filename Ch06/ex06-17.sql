CREATE PROCEDURE sp_update_employee_dob
	(p_employee_id INT, p_dob DATE)
BEGIN
	DECLARE employee_is_too_young CONDITION FOR SQLSTATE '99001';
	
	IF DATE_SUB(CURDATE(), INTERVAL 16 YEAR) <P_DOB THEN
		SIGNAL employee_is_too_young 
            SET MESSAGE_TEST='Employee must be 16 years or older'; 
	ELSE
		UPDATE employees 
		   SET date_of_birth=p_dob
		 WHERE employee_id=p_employee_id;
	END IF;
END;
