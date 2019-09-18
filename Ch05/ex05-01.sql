
CREATE PROCEDURE simple_sqls()
BEGIN
	DECLARE i INT DEFAULT 1;
	
	/* Example of a utility statement */
	SET autocommit=0;
	
	/* Example of DDL statements */
	DROP TABLE IF EXISTS test_table ;
	CREATE TABLE test_table 
		(id        INT PRIMARY KEY,
		 some_data VARCHAR(30))
	  ENGINE=innodb;
	
	/* Example of an INSERT using a procedure variable */
	WHILE (i<=10) DO
		INSERT INTO TEST_TABLE VALUES(i,CONCAT("record ",i));
		SET i=i+1;
	END WHILE;  
	
	/* Example of an UPDATE using procedure variables*/
	SET i=5;
	UPDATE test_table
	   SET some_data=CONCAT("I updated row ",i)
	 WHERE id=i;
	 
	/* DELETE with a procedure variable */
	DELETE FROM test_table 
	 WHERE id>i; 
		 
END;
