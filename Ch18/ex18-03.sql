CREATE PROCEDURE sp_employee_list(in_department_id DECIMAL(8,0))
	SQL SECURITY DEFINER READS SQL DATA
BEGIN
	DECLARE l_user_name VARCHAR(30);
	DECLARE l_not_found INT DEFAULT 0;
	DECLARE l_department_name VARCHAR(30);
	DECLARE l_manager_id INT;
	
	DECLARE user_csr CURSOR FOR 
		SELECT d.department_name,e.manager_id 
		  FROM departments d JOIN employees e USING(department_id)
		 WHERE db_user=l_user_name;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_not_found=1;	

	/* Strip out the host from the user name */
	SELECT  SUBSTR(USER(),1,INSTR(USER(),'@')-1) 
	 INTO l_user_name;
	
	OPEN user_csr;
	FETCH user_csr INTO l_department_name,l_manager_id;
	CLOSE user_csr;
	
	IF l_department_name='PAYROLL' OR l_manager_id IN (0,1) THEN 
		 SELECT surname,firstname,salary 
		   FROM employees 
			WHERE department_id=in_department_id 
			ORDER BY employee_id;
	ELSE
		 /* Not authorized to see salary */
		 SELECT surname,firstname,'XXXXXXX' AS salary 
		   FROM employees 
			WHERE department_id=in_department_id 
			ORDER BY employee_id; 
	END IF;
		
END;
