CREATE PROCEDURE filesize(in_file_name VARCHAR(128))
 
BEGIN
  DECLARE mytext TEXT;
  SET mytext=LOAD_FILE(in_file_name);
  SELECT in_file_name||' contains '||length(mytext)||' bytes'
      AS output;
END
