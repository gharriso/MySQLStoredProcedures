CREATE FUNCTION borrower_old_enough (in_dob DATE)
  RETURNS INT
    DETERMINISTIC 
BEGIN
  DECLARE  v_retval INT DEFAULT 0;
  IF (in_dob < DATE_SUB(NOW(), INTERVAL 10 YEAR)) THEN
    SET  v_retval=1;
  ELSE
    SET  v_retval=0;
  END IF;
  RETURN( v_retval);
END;
