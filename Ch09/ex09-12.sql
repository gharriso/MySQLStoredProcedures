CREATE PROCEDURE sp_critical_section() 
  
 BEGIN
    DECLARE lock_result INT;
    IF get_lock('sp_critical_section_lock',60) THEN 
       /* This block can only be run by one user at a time*/
       SELECT 'got lock';
       /* Critical code here */
      SET lock_result=release_lock('sp_critical_section_lock');
    ELSE
       SELECT 'failed to acquire lock';
       /* Error handling here */
    END IF;
 END;
