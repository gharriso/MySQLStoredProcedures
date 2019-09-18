CREATE PROCEDURE ascii_chart()
BEGIN
        DECLARE i INT DEFAULT 1;

        CREATE TEMPORARY TABLE ascii_chart
            (ascii_code int, ascii_char CHAR(1));

        WHILE (i<=128) DO
               INSERT INTO ascii_chart VALUES(i,CHAR(i));
               SET i=i+1;
        END WHILE;

END
