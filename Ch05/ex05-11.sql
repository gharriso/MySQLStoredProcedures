

	DECLARE dept_csr CURSOR FOR
		SELECT department_id,department_name, location
		  FROM departments;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_departments=1;
	
    SET no_more_departments=0; 
	OPEN dept_csr;
	REPEAT
		FETCH dept_csr INTO l_department_id,l_department_name,l_location;
	UNTIL no_more_departments
	END REPEAT;
	CLOSE dept_csr;
	SET no_more_departments=0;
