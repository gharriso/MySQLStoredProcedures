CREATE PROCEDURE `my_signal`(in_errortext VARCHAR(255))
BEGIN
   SET @sql=CONCAT('UPDATE `',
            in_errortext,
            '` SET x=1');

   PREPARE my_signal_stmt FROM @sql;
   EXECUTE my_signal_stmt;
   DEALLOCATE PREPARE my_signal_stmt;
END
