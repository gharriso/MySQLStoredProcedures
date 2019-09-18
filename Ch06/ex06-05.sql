CREATE PROCEDURE sp_not_found()
    READS SQL DATA
BEGIN
	DECLARE l_last_row INT DEFAULT 0;
	DECLARE l_dept_id  INT;
	DECLARE c_dept CURSOR FOR
          SELECT department_id
            FROM departments;
	/* handler to set l_last_row=1 if a cursor returns no more rows */
	DECLARE continue handler for NOT FOUND SET l_last_row=1;
	
	OPEN c_dept;
	dept_cursor: LOOP
		FETCH c_dept INTO l_dept_id;
		IF (l_last_row=1) THEN
			LEAVE dept_cursor;
		END IF;
		/* Do something with the data*/

	END LOOP dept_cursor;
	CLOSE c_dept;

END;
