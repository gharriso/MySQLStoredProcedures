CREATE PROCEDURE nested_tfer_funds(
  in_from_acct INTEGER,
  in_to_acct   INTEGER,
  in_tfer_amount DECIMAL(8,2))
BEGIN

  DECLARE txn_error INTEGER DEFAULT 0 ;

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN
    SET txn_error=1;
  END;

  SAVEPOINT savepoint_tfer;

  UPDATE account_balance
     SET balance=balance-in_tfer_amount
   WHERE account_id=in_from_acct;

  IF txn_error THEN
    ROLLBACK TO savepoint_tfer;
    SELECT 'Transfer aborted ';
  ELSE
    UPDATE account_balance
       SET balance=balance+in_tfer_amount
     WHERE account_id=in_to_acct;

     IF txn_error THEN
        ROLLBACK TO savepoint_tfer;
        SELECT 'Transfer aborted ';
     END IF;
  END IF;

END;
