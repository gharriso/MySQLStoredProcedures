CREATE PROCEDURE pay_out_balance
    (account_id_in INT)
  
BEGIN

  DECLARE l_balance_remaining NUMERIC(10,2);

  payout_loop:LOOP
    SET l_balance_remaining = account_balance(account_id_in);

    IF l_balance_remaining < 1000 THEN
      LEAVE payout_loop;

    ELSE
      CALL apply_balance(account_id_in, l_balance_remaining);
    END IF;

  END LOOP;

END
