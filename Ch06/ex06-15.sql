	DECLARE sqlcode INT DEFAULT 0;
	DECLARE status_message VARCHAR(50);

 	DECLARE CONTINUE HANDLER FOR duplicate_key	 
	BEGIN
		SET sqlcode=1052;
		SET status_message='Duplicate key error';
	END; 
	
 	DECLARE CONTINUE HANDLER FOR foreign_key_violated
	BEGIN
		SET sqlcode=1216;
		SET status_message='Foreign key violated';
	END;
	
 	DECLARE CONTINUE HANDLER FOR NOT FOUND 
	BEGIN
		SET sqlcode=1329;
		SET status_message='No record found';
	END;
