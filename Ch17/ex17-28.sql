CREATE PROCEDURE sp_two_results()
BEGIN
	SELECT location,address1,address2 
	  FROM locations; 
	SELECT department_id,department_name 
	  FROM departments;
END;
