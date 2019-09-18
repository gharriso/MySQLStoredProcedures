CREATE PROCEDURE update_anything_2
  (in_table     VARCHAR(60),
   in_where_col VARCHAR(60),
   in_set_col   VARCHAR(60),
   in_where_val VARCHAR(60),
   in_set_val   VARCHAR(60))   
BEGIN

  DECLARE  v_count INT;

  SELECT COUNT(*)
    INTO  v_count
    FROM information_schema.columns
   WHERE table_name=in_table
     AND column_name IN (in_set_col,in_where_col);

  IF ( v_count <2 ) THEN
    SELECT 'Invalid table or column names provided';
  ELSE
    SET @dyn_sql=CONCAT(
      'UPDATE ' , in_table ,
        ' SET ' ,in_set_col, ' = ?
        WHERE ' , in_where_col, ' = ?');

   SELECT @dyn_sql;
   PREPARE s1 FROM @dyn_sql;
   SET @where_val=in_where_val;
   SET @set_val=in_set_val;
   EXECUTE s1 USING @where_val,@set_val;
   DEALLOCATE PREPARE s1;
 END IF;

END;
