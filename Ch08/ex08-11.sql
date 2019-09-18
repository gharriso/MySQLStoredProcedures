CREATE PROCEDURE tfer_funds5
       (from_account int, to_account int,tfer_amount numeric(10,2),
        OUT status int, OUT message VARCHAR(30))
BEGIN
	DECLARE from_account_balance NUMERIC(10,2);
	
	START TRANSACTION;
	
	SELECT balance
	  INTO from_account_balance
	  FROM account_balance
	 WHERE account_id=from_account
	   FOR UPDATE;
	 
	IF from_account_balance>=tfer_amount THEN  
	
		UPDATE account_balance
		   SET balance=balance-tfer_amount
		 WHERE account_id=from_account;
	 
		UPDATE account_balance
		   SET balance=balance+tfer_amount
		 WHERE account_id=to_account;
		COMMIT;
		
		SET status=0;
		SET message='OK';
	ELSE
		ROLLBACK;
		SET status=-1;
		SET message='Insufficient funds';
	END IF;
END; 
