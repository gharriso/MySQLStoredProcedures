CREATE TRIGGER account_balance_bu
   BEFORE UPDATE 
    ON account_balance 
   FOR EACH ROW
BEGIN
    -- The account balance cannot be set to a negative value.
	IF (NEW.balance < 0) THEN
        -- Warning! Not implemented in MySQL 5.0...                                                   
        SIGNAL SQLSTATE '80000'
            SET MESSAGE_TEXT='Account balance cannot be less than 0';                    
	END IF;
END;
