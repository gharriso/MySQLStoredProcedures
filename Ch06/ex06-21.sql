CREATE PROCEDURE sp_add_department
	  (p_department_name         varchar(30),
	   p_manager_surname         VARCHAR(30),
	   p_manager_firstname       VARCHAR(30),
	   p_location                varchar(30),
	   out p_sqlcode             int,
	   out p_status_message      varchar(100))
  MODIFIES SQL DATA
BEGIN

	DECLARE l_manager_id       INT;
	DECLARE csr_mgr_id cursor for
		SELECT employee_id
	  	  FROM employees
	 	 WHERE surname=UPPER(p_manager_surname)
	   	   AND firstname=UPPER(p_manager_firstname);

	OPEN csr_mgr_id;
	FETCH csr_mgr_id INTO l_manager_id;
	
	INSERT INTO departments (department_name,manager_id,location)
	VALUES(UPPER(p_department_name),l_manager_id,UPPER(p_location));
	
	CLOSE csr_mgr_id;
END