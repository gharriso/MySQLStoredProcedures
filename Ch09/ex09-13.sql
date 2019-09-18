CREATE PROCEDURE sp_mysql_version()
  
BEGIN
  DECLARE major_version INT;
  
  SET major_version=SUBSTR(version(),1,INSTR(version(),'.')-1);
  IF major_version>=5 THEN
     SELECT 'Good thing you are using version 5 or later';
  ELSE
     SELECT 'This version of MySQL does not support stored procedures',
            'you must be dreaming';
  END IF;

END;
