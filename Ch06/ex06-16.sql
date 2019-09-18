CREATE PROCEDURE sp_update_employee_dob
	(p_employee_id INT, p_dob DATE, OUT p_status varchar(30))
BEGIN
	IF DATE_SUB(curdate(), INTERVAL 16 YEAR) <p_dob THEN
		SET p_status='Employee must be 16 years or older'; 
	ELSE
		UPDATE employees 
		   SET date_of_birth=p_dob
		 WHERE employee_id=p_employee_id;
		 SET p_status='Ok';
	END IF;
END;
