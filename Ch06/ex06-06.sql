CREATE PROCEDURE add_department
      (in_dept_name VARCHAR(30),
       in_location VARCHAR(30),
       in_manager_id INT)
    MODIFIES SQL DATA
BEGIN
    DECLARE duplicate_key INT DEFAULT 0;
    BEGIN
		DECLARE EXIT HANDLER FOR 1062 /* Duplicate key*/ SET duplicate_key=1;
		
		INSERT INTO departments (department_name,location,manager_id)
	 	VALUES(in_dept_name,in_location,in_manager_id);
			
		SELECT CONCAT('Department ',in_dept_name,' created') as "Result";
	END;
		
	IF duplicate_key=1 THEN
		SELECT CONCAT('Failed to insert ',in_dept_name,
                       ': duplicate key') as "Result";
	END IF;
END
