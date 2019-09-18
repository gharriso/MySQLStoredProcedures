	DECLARE l_int1      INT DEFAULT -2000000;
	DECLARE l_int2      INT UNSIGNED DEFAULT 4000000;
	DECLARE l_bigint1   BIGINT DEFAULT 4000000000000000;
	DECLARE l_float     FLOAT DEFAULT 1.8e8;
	DECLARE l_double    DOUBLE DEFAULT 2e45;
	DECLARE l_numeric   NUMERIC(8,2) DEFAULT 9.95;
	
	DECLARE l_date      DATE DEFAULT '1999-12-31';
	DECLARE l_datetime  DATETIME DEFAULT '1999-12-31 23:59:59';
	
	DECLARE l_char      CHAR(255) DEFAULT 'This will be padded to 255 chars';
	DECLARE l_varchar   VARCHAR(255) DEFAULT 'This will not be padded';
	
	DECLARE l_text      TEXT DEFAULT 'This is a really long string.  In stored programs we can use text columns fairly freely, but in tables there are some limitations regarding indexing and use in various expressions.';
