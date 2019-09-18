CREATE PROCEDURE sp_fetch_forever()
  READS SQL DATA
BEGIN
	DECLARE l_dept_id  INT;
	DECLARE c_dept CURSOR FOR
            SELECT department_id
              FROM departments;
	
	OPEN c_dept;
	dept_cursor: LOOP
		FETCH c_dept INTO l_dept_id;
	END LOOP dept_cursor;
	CLOSE c_dept;
END
