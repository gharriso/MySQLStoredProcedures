CREATE PROCEDURE tfer_funds
       (from_account int, to_account int,tfer_amount numeric(10,2))
BEGIN
	START TRANSACTION;
	
	UPDATE account_balance
	   SET balance=balance-tfer_amount
	 WHERE account_id=from_account;
	 
	UPDATE account_balance
	   SET balance=balance+tfer_amount
	 WHERE account_id=to_account;
	 
	COMMIT;
END;
