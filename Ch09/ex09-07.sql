CREATE FUNCTION count_strings
      (in_string VARCHAR(256),in_substr VARCHAR(128))
  RETURNS INT
  DETERMINISTIC 
BEGIN
  DECLARE l_count INT DEFAULT 0;
  DECLARE l_start INT DEFAULT 1;
  DECLARE l_pos   INT;

  MainLoop:
  LOOP
    SET l_pos=LOCATE(in_substr,in_string,l_start);
    IF l_pos=0 THEN
       LEAVE MainLoop;
    ELSE
      SET l_count=l_count+1;
      SET l_start=l_pos+1;
    END IF;

  END LOOP;
  RETURN(l_count);
END
