CREATE PROCEDURE tfer_funds
       (from_account INT, to_account INT,tfer_amount NUMERIC(10,2))
	SQL SECURITY INVOKER		
BEGIN
	START TRANSACTION;
	
	UPDATE account_balance
	   SET balance=balance-tfer_amount
	 WHERE account_id=from_account;
	 
	UPDATE account_balance
	   SET balance=balance+tfer_amount
	 WHERE account_id=to_account;
	
	INSERT into transaction_log 
	 (user_id, description)
	 values(user(), concat('Transfer of ',tfer_amount,' from ',
	        from_account,' to ',to_account));
	 
	COMMIT;
END; 
