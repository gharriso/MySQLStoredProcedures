
	OPEN dept_csr;
	dept_loop1:LOOP
		FETCH dept_csr INTO l_department_id,l_department_name,l_location;
		IF no_more_departments=1 THEN 
			LEAVE dept_loop1; 
		END IF;
		SET l_department_count=l_department_count+1;
	END LOOP;
	CLOSE dept_csr;
	SET no_more_departments=0;
