
SET i=0;
loop1: LOOP
	SET i=i+1;
	IF i>=10 THEN          /*Last number - exit loop*/
		LEAVE loop1;
	ELSEIF MOD(i,2)=0 THEN /*Even number - try again*/
		ITERATE loop1;
	END IF;

	SELECT CONCAT(i," is an odd number");
		
END LOOP loop1;

