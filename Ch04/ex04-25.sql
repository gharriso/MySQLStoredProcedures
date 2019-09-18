
DECLARE i,j INT DEFAULT 1;
outer_loop: LOOP
	SET j=1;
	inner_loop: LOOP
		SELECT CONCAT(i," times ", j," is ",i*j);
		SET j=j+1;
		IF j>12 THEN 
			LEAVE inner_loop;
		END IF;
	END LOOP inner_loop;
	SET i=i+1;
	IF i>12 THEN 
		LEAVE outer_loop;
	END IF;
END LOOP outer_loop;
