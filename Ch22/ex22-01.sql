CREATE PROCEDURE sp_nprimes(p_num int)
BEGIN
	DECLARE i INT;
	DECLARE j INT;
	DECLARE nprimes INT; 
	DECLARE  isprime INT;  
	
	SET i=2;
	SET nprimes=0;
	
	main_loop:
	WHILE (i<p_num) DO
		SET isprime=1;
		SET j=2;
		divisor_loop:
		WHILE (j<i) DO
			IF (MOD(i,j)=0) THEN
				SET isprime=0;
				LEAVE divisor_loop;
			END IF;
			SET j=j+1;
		END WHILE ;
		IF (isprime=1) THEN 
			SET nprimes=nprimes+1; 
		END IF; 
		SET i=i+1;
	END WHILE;
	SELECT CONCAT(nprimes,' prime numbers less than ',p_num); 
END;
