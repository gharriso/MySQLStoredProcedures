CREATE PROCEDURE variable_demo()
BEGIN
    DECLARE my_integer     INT;           /* 32-bit integer */
    DECLARE my_big_integer BIGINT;        /* 64-bit integer */
    DECLARE my_currency    NUMERIC(8,2);  /* Number with 2 decimals*/
    DECLARE my_pi          FLOAT          /* Floating point number*/
            DEFAULT 3.1415926;            /* initialized as PI */
    DECLARE my_text        TEXT;          /* huge  text */
    DECLARE my_dob         DATE
            DEFAULT '1960-06-21';         /* My Birthday */
    DECLARE my_varchar     VARCHAR(30)
            DEFAULT 'Hello World!';       /* 30 bytes of text*/

    SET my_integer=20;
    SET my_big_integer=POWER(my_integer,3);

END;
