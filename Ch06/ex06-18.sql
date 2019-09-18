CREATE PROCEDURE sp_update_employee_dob2
	(p_employee_id INT, p_dob DATE)
BEGIN
	
	IF datediff(curdate(),p_dob)<(16*365) THEN
		UPDATE `Error: employee_is_too_young; Employee must be 16 years or older`
		   SET x=1; 
	ELSE
		UPDATE employees 
		   SET date_of_birth=p_dob
		 WHERE employee_id=p_dob;
	END IF;
END;
