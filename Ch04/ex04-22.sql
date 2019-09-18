
SET i=0;
loop1: REPEAT
	SET i=i+1;
	IF MOD(i,2)<>0 THEN /*Even number - try again*/	
	   SELECT CONCAT(i," is an odd number");
	END IF;
UNTIL i >= 10	
END REPEAT;
