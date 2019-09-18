create procedure tfer_funds2
       (from_account int, to_account int,
        tfer_amount numeric(10,2), OUT out_status INT,
        OUT out_message VARCHAR(30))
BEGIN

	DECLARE deadlock INT DEFAULT 0;
	DECLARE attempts INT DEFAULT 0;

	tfer_loop:WHILE (attempts<3) DO
		BEGIN
			DECLARE deadlock_detected CONDITION FOR 1213;
			DECLARE EXIT HANDLER FOR deadlock_detected 
				BEGIN
					ROLLBACK;
					SET deadlock=1;
				END;
			SET deadlock=0;
			
			START TRANSACTION;
				
			UPDATE account_balance
			   SET balance=balance-tfer_amount
			 WHERE account_id=from_account;
	 		
			UPDATE account_balance
		 	  SET balance=balance+tfer_amount
			 WHERE account_id=to_account;
			 
			COMMIT;
			
		END;
		IF deadlock=0 THEN
			LEAVE tfer_loop;
		ELSE
			SET attempts=attempts+1;	
		END IF;
	END WHILE tfer_loop;
	
	IF deadlock=1 THEN
		SET out_status=-1;
		SET out_message="Failed with deadlock for 3 attempts";
		
	ELSE
		SET out_status=0;
		SET out_message=CONCAT("OK (",attempts," deadlocks)");
	END IF;
		
END;
