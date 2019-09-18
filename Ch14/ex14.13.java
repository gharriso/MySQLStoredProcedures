CREATE PROCEDURE sp_test_inout_rs2(IN in_user VARCHAR(30),OUT table_count INT)
BEGIN

  SELECT table_name,table_type
    FROM information_schema.tables
   WHERE upper(table_schema)=upper(in_user);

  SELECT routine_name,routine_type
    FROM information_schema.routines
   WHERE upper(routine_schema)=upper(in_user);

  SELECT COUNT(*)
    INTO table_count
    FROM information_schema.tables
   where upper(table_schema)=upper(in_user);

END ;
