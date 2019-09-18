CREATE TRIGGER account_balance_au
 AFTER UPDATE ON account_balance FOR EACH ROW
 BEGIN
		INSERT into transaction_log 
		       (user_id, description)
		VALUES (user(), 
		        CONCAT('Adjusted account ',
	        	   NEW.account_id,' from ',OLD.balance, 
	        	   ' to ', NEW.balance));     	
END;
