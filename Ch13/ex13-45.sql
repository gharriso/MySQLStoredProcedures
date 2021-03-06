CREATE PROCEDURE `sp_mysql_info`(in_database VARCHAR(60),    
       OUT server_version VARCHAR(100))
    READS SQL DATA
BEGIN   

  DECLARE db_count INT;

  SELECT @@version   
    INTO server_version;

  SELECT 'Current processes active in server' as table_header;   
  SHOW FULL PROCESSLIST;
     
       
  SELECT 'Databases in server' as table_header;   

  SHOW DATABASES;
   
  SELECT 'Configuration variables set in server' as table_header;
  SHOW GLOBAL VARIABLES;
  SELECT 'Status variables in server' as table_header;
  SHOW GLOBAL STATUS;
     

  SELECT COUNT(*)    
    INTO db_count
    FROM information_schema.schemata s   
   WHERE schema_name=in_database;
  IF (db_count=1) THEN     
    SELECT CONCAT('Tables in database ',in_database) as table_header;   
    SELECT table_name   
      FROM information_schema.tables
     WHERE table_schema=in_database;
  END IF;   
       
END;
