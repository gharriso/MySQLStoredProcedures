SELECT CONCAT(routine_schema,'.',routine_name),
       routine_type,routine_definition
  FROM information_schema.routines;