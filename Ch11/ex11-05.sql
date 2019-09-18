CREATE TRIGGER account_balance_bu
  BEFORE UPDATE
      ON account_balance
     FOR EACH ROW
BEGIN
   DECLARE dummy INT;
   IF NEW.balance<0 THEN
      SELECT `Account balance cannot be less than 0` INTO dummy
        FROM account_balance
       WHERE account_id=NEW.account_id;
  END IF;
END; 
