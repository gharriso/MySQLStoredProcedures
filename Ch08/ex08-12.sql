
CREATE PROCEDURE tfer_funds6
       (from_account INT, to_account INT, tfer_amount NUMERIC(10,2),
        OUT status INT, OUT message VARCHAR(30) )
    
BEGIN

  DECLARE from_account_balance    NUMERIC(8,2);
  DECLARE from_account_balance2   NUMERIC(8,2);
  DECLARE from_account_timestamp1 TIMESTAMP;
  DECLARE from_account_timestamp2 TIMESTAMP;

  SELECT account_timestamp,balance
    INTO from_account_timestamp1,from_account_balance
    FROM account_balance
   WHERE account_id=from_account;

  IF (from_account_balance>=tfer_amount) THEN

    -- Here we perform some long running validation that
    -- might take a few minutes */
    CALL long_running_validation(from_account);

    START TRANSACTION;

    -- Make sure the account row has not been updated since
    --         our initial check
    SELECT account_timestamp, balance
      INTO from_account_timestamp2,from_account_balance2
      FROM account_balance
     WHERE account_id=from_account
       FOR UPDATE;

     IF (from_account_timestamp1 <> from_account_timestamp2 OR
         from_account_balance    <> from_account_balance2)  THEN
       ROLLBACK;
       SET status=-1;
       SET message=CONCAT("Transaction cancelled due to concurrent update",
                          " of account"  ,from_account);
    ELSE
       UPDATE account_balance
          SET balance=balance-tfer_amount
        WHERE account_id=from_account;

       UPDATE account_balance
          SET balance=balance+tfer_amount
        WHERE account_id=to_account;

       COMMIT;

       SET status=0;
       SET message="OK";
    END IF;

  ELSE
    ROLLBACK;
    SET status=-1;
    SET message="Insufficient funds";
  END IF;
END$$
