CREATE FUNCTION cust_status(IN in_status CHAR(1))
	RETURNS VARCHAR(20)
BEGIN
	DECLARE long_status VARCHAR(20);
	
	IF in_status = 'O' THEN
		SET long_status='Overdue';
	ELSEIF in_status = 'U' THEN 
		SET long_status='Up to date';
	ELSEIF in_status = 'N' THEN
		SET long_status='New';
	END IF;
	
	RETURN(long_status);
END;
