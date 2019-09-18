CREATE PROCEDURE check_billing_status
    (in_due_date DATE, 
     OUT status_code INT, 
     OUT status_message VARCHAR(30))
BEGIN
  DECLARE days_past_due INT;
   
  SET days_past_due=FLOOR(DATEDIFF(now(),in_due_date));
  IF days_past_due>90 THEN 
    SET status_code=-2;
    SET status_message='Bill more than 90 days overdue';
  ELSEIF days_past_due >30 THEN
    SET status_code=-1;
    SET status_message='Bill more than 30 days overdue';
  ELSE
    SET status_code=0;
    SET status_message='OK';
 
  END IF;
END;
