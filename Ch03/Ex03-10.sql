CREATE PROCEDURE operators()
BEGIN
        DECLARE a INT DEFAULT 2;
        DECLARE b INT DEFAULT 3;
        DECLARE c FLOAT;

        SET c=a+b; SELECT 'a+b=',c;
        SET c=a/b; SELECT 'a/b=',c;
        SET c=a*b; SELECT 'a*b=',c;


        IF (a<b) THEN
                SELECT 'a is less than b';
        END IF;
        IF NOT (a=b) THEN
                SELECT 'a is not equal to b';
        END IF;
END;
