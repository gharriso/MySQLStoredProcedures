CREATE FUNCTION status_desc (in_cd CHAR(1))
  RETURNS VARCHAR(20)
    
    DETERMINISTIC
BEGIN

   IF in_cd = 'C' THEN
      RETURN 'CLOSED';
   ELSEIF in_cd = 'O' THEN
      RETURN 'OPEN';
   ELSEIF in_cd = 'I' THEN
      RETURN 'INACTIVE';
   END IF;
END;
