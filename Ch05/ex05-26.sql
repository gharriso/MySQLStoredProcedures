CREATE PROCEDURE execute_immediate(in_sql varchar(4000))
BEGIN

  SET @tmp_sql=in_sql;
  PREPARE s1 FROM @tmp_sql;
  EXECUTE s1;
  DEALLOCATE PREPARE s1;

END;
