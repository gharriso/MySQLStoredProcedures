CREATE PROCEDURE sp_add_department2
    (p_department_name         VARCHAR(30),
	 p_manager_surname         VARCHAR(30),
	 p_manager_firstname       VARCHAR(30),
	 p_location                VARCHAR(30),
	 OUT p_sqlcode             INT,
	 OUT p_status_message      VARCHAR(100))
BEGIN

/* START Declare Conditions */

  DECLARE duplicate_key CONDITION FOR 1062;
  DECLARE foreign_key_violated CONDITION FOR 1216;

/* END Declare Conditions */

/* START Declare variables and cursors */
	
	DECLARE l_manager_id       INT;
		
	DECLARE csr_mgr_id CURSOR FOR
	 SELECT employee_id
	   FROM employees
	  WHERE surname=UPPER(p_manager_surname)
	   	AND firstname=UPPER(p_manager_firstname);

/* END Declare variables and cursors */

/* START Declare Exception Handlers */         	
	
  DECLARE CONTINUE HANDLER FOR duplicate_key
    BEGIN
      SET p_sqlcode=1052;
      SET p_status_message='Duplicate key error';
    END;
	
  DECLARE CONTINUE HANDLER FOR foreign_key_violated
    BEGIN
      SET p_sqlcode=1216;
      SET p_status_message='Foreign key violated';
    END;
	
  DECLARE CONTINUE HANDLER FOR not FOUND
    BEGIN
      SET p_sqlcode=1329;
      SET p_status_message='No record found';
    END;	

/* END Declare Exception Handlers */

/* START Execution */
	
  SET p_sqlcode=0;
  OPEN csr_mgr_id;
  FETCH csr_mgr_id INTO l_manager_id;
	
  IF p_sqlcode<>0 THEN 		/* Failed to get manager id*/
    SET p_status_message=CONCAT(p_status_message,' when fetching manager id');
  ELSE
					/* Got manager id, we can try and insert */
    INSERT INTO departments (department_name,manager_id,location)
    VALUES(UPPER(p_department_name),l_manager_id,UPPER(p_location));
    IF p_sqlcode<>0 THEN	/* Failed to insert new department */
      SET p_status_message=CONCAT(p_status_message,
                           ' when inserting new department');
    END IF;
  END IF;
	
  CLOSE csr_mgr_id;

/* END Execution */

END
