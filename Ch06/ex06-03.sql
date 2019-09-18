CREATE PROCEDURE sp_add_department
       (in_department_name VARCHAR(30),
        in_manager_id      INT,
        in_location        VARCHAR(30),
        in_address1        VARCHAR(30),
        in_address2        VARCHAR(30),
        in_zipcode         VARCHAR(10)
       )
	MODIFIES SQL DATA
BEGIN
	DECLARE l_status VARCHAR(20);

	CALL sp_add_location(in_location,in_address1,in_address2,
                         in_zipcode, l_status);
  	IF l_status='Duplicate Entry' THEN
    		SELECT CONCAT('Warning: using existing definition for location ',
                        in_location) AS warning;
	END IF;

	INSERT INTO departments (manager_id,department_name,location)
	VALUES(in_manager_id,in_department_name,in_location);

END;
