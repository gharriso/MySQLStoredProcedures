CREATE FUNCTION my_replace
   (in_string      VARCHAR(255),
    in_find_str    VARCHAR(20),
    in_repl_str    VARCHAR(20))

  RETURNS VARCHAR(255)
BEGIN
  DECLARE l_new_string VARCHAR(255);
  DECLARE l_find_pos   INT;

  SET l_find_pos=INSTR(in_string,in_find_str);

  IF (l_find_pos>0) THEN
    SET l_new_string=INSERT(in_string,l_find_pos,LENGTH(in_find_str),in_repl_str);
  ELSE
    SET l_new_string=in_string;
  END IF;
  RETURN(l_new_string);

END
