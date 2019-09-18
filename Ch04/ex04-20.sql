
SET i=1;
myloop: LOOP
	SET i=i+1;
	IF i=10 THEN
    		LEAVE myloop;
	END IF;
END LOOP myloop;
SELECT 'I can count to 10';
