 CREATE PROCEDURE set_col_value
       (in_table     VARCHAR(128),
        in_column    VARCHAR(128),
        in_new_value VARCHAR(1000),
        in_where     VARCHAR(4000))
   
BEGIN
   DECLARE l_sql VARCHAR(4000);
   SET l_sql=CONCAT_ws(' ',
               'UPDATE',in_table,
                  'SET',in_column,'=',in_new_value,
               ' WHERE',in_where);
   SET @sql=l_sql;
   PREPARE s1 FROM @sql;
   EXECUTE s1;
   DEALLOCATE PREPARE s1;
END;
