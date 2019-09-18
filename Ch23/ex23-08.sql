CREATE PROCEDURE update_anything
  (in_table     VARCHAR(60),
   in_where_col VARCHAR(60),
   in_set_col   VARCHAR(60),
   in_where_val VARCHAR(60),
   in_set_val   VARCHAR(60))   
BEGIN

  SET @dyn_sql=CONCAT(
      'UPDATE ' , in_table ,
        ' SET ' ,in_set_col, ' = ?
        WHERE ' , in_where_col, ' = ?');

 PREPARE s1 FROM @dyn_sql;
 SET @where_val=in_where_val;
 SET @set_val=in_set_val;
 EXECUTE s1 USING @where_val,@set_val;
 DEALLOCATE PREPARE s1;

END$$
