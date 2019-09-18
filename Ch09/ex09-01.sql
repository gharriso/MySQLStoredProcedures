CREATE FUNCTION ascii_string (in_string varchar(80) )
 RETURNS VARCHAR(256)
 NO SQL
BEGIN
   DECLARE i INT DEFAULT 1;
      DECLARE string_len INT;
      DECLARE out_string VARCHAR(256) DEFAULT '';

      SET string_len=length(in_string);
      WHILE (i<string_len) DO
         SET out_string=CONCAT(out_string,ASCII(substr(in_string,i,1)),' ');
         SET i=i+1;
      END WHILE;
      RETURN (out_string);

END
