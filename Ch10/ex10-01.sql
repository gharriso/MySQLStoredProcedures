CREATE FUNCTION cust_status(in_status CHAR(1))
	RETURNS VARCHAR(20)
BEGIN
	IF in_status = 'O' THEN
		RETURN('Overdue');
	ELSEIF in_status = 'U' THEN 
		RETURN('Up to date');
	ELSEIF in_status = 'N' THEN
		RETURN('New');
	END IF;
END; 
