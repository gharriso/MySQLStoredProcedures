
SET i=1;
loop1: WHILE i<=10 DO		
	IF MOD(i,2)<>0 THEN /*Even number - try again*/	
	   SELECT CONCAT(i," is an odd number");
	END IF;
	SET i=i+1;
END WHILE loop1;
