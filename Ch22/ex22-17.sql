IF (employee_status='U') THEN 
	IF (employee_salary>150000) THEN
		SET categoryA=categoryA+1;
	ELSEIF (employee_salary>100000) THEN
		SET categoryB=categoryB+1;
	ELSEIF (employee_salary<50000) THEN
		SET categoryC=categoryC+1;
	ELSE 
		SET categoryD=categoryD+1;
	END IF;
END IF;
