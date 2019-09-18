create procedure tfer_funds3
       (from_account int, to_account int,tfer_amount numeric(10,2))
BEGIN
	DECLARE local_account_id INT;
	DECLARE lock_cursor CURSOR FOR 
		SELECT account_id
		  FROM account_balance
		 WHERE account_id IN (from_account,to_account)
		 ORDER BY account_id
		   FOR UPDATE;
		   
	START TRANSACTION;
	
	OPEN lock_cursor;
	FETCH lock_cursor INTO local_account_id;
	
	UPDATE account_balance
	   SET balance=balance-tfer_amount
	 WHERE account_id=from_account;
	 
	UPDATE account_balance
	   SET balance=balance+tfer_amount
	 WHERE account_id=to_account;
	 
	CLOSE lock_cursor;
	 
	COMMIT;
END;  
