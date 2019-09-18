	SET l_isodd=isodd(aNumber);
	
	IF (isodd(aNumber)) THEN
		SELECT CONCAT(aNumber," is odd") as isodd;
	ELSE
		SELECT CONCAT(aNumber," is even") AS isodd;
	END IF; 
