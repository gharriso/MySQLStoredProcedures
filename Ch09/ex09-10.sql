CREATE PROCEDURE validate_age
    (in_dob DATE, 
     OUT status_code INT, 
     OUT status_message VARCHAR(30))
BEGIN
   
  IF DATE_SUB(now(), INTERVAL 18 YEAR) <in_dob THEN 
    SET status_code=-1;
    SET status_message="Error: employee is less than 18 years old";
  ELSE
    SET status_code=0;
    SET status_message="OK";
  END IF;
END;
