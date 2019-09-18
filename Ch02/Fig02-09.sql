DROP PROCEDURE IF EXISTS simple_loop
$$
CREATE PROCEDURE simple_loop()
  DETERMINISTIC
BEGIN

  DECLARE counter INT DEFAULT 0;

  simple_loop: LOOP
    SET counter=counter+1;
    IF counter=10 THEN
       LEAVE simple_loop;
    END IF;
  END LOOP simple_loop;
  SELECT 'I can count to 10';
END;
$$