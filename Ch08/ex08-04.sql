CREATE PROCEDURE nosavepoint_example(in_department_name VARCHAR(30),
                                   in_location VARCHAR(30),
                                   in_address1 VARCHAR(30),
                                   in_address2 VARCHAR(30),
                                   in_zipcode  VARCHAR(10),
                                   in_manager_id INT)
BEGIN
	DECLARE location_exists    INT DEFAULT 0;
	DECLARE department_exists  INT DEFAULT 0;
		
	START TRANSACTION;
	
	-- Does the location exist?
	SELECT COUNT(*)
	  INTO location_exists
	  FROM locations
	 WHERE location=in_location;
	 
	IF location_exists=0 THEN
	
		INSERT INTO AUDIT_LOG (audit_message)
		               VALUES (CONCAT('Creating new location',in_location));
									
		INSERT INTO locations (location,address1,address2,zipcode)
		 VALUES (in_location,in_address1,in_address2,in_zipcode);
	ELSE
	
		UPDATE locations set address1=in_address1,
				    address2=in_address2,
				    zipcode=in_zipcode
		 WHERE location=in_location;
		                  
	END IF;
	
	-- Does the department exists?
	SELECT COUNT(*)
	  INTO department_exists
		FROM departments
	 WHERE department_name=in_department_name;
	
	IF department_exists=1 THEN 
	
		 UPDATE departments
			  SET location=in_location,
			     manager_id=in_manager_id
			WHERE department_name=in_department_name;
			
	ELSE
		
		INSERT INTO AUDIT_LOG (audit_message)
		       VALUES (CONCAT('Creating new department',in_department_name));
		        
		INSERT INTO DEPARTMENTS (department_name,location,manager_id)
		       VALUES (in_department_name,in_location, in_manager_id);
		                 
	END IF;
		                 	
	COMMIT;
	
END;
