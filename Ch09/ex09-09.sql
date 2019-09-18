CREATE PROCEDURE select_winner()
  READS SQL DATA
BEGIN
  DECLARE winner_id INT;
  DECLARE max_employee_id INT;
  DECLARE winner_name VARCHAR(70);
  
  SELECT MAX(employee_id)
    INTO max_employee_id 
    FROM employees;
  
  SET winner_id=FLOOR(RAND()*max_employee_id)+1;
  
  SELECT CONCAT_WS(' ','Employee of the week is',firstname,surname)
    FROM employees
   WHERE employee_id=winner_id;
END;
