CREATE TRIGGER account_balance_au
 AFTER UPDATE ON account_balance FOR EACH ROW
BEGIN
  DECLARE dummy INT;

  IF NEW.balance<0 THEN
     SET NEW.balance=NULL;
  END IF;

END
