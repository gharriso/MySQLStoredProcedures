CREATE PROCEDURE bulk_processing_example()
  MODIFIES SQL DATA
BEGIN
  DECLARE delete_count INT DEFAULT 0;
  DECLARE last_row     INT DEFAULT 0;
  DECLARE l_rec_id     INT;
  
  DECLARE c1 CURSOR FOR SELECT rec_id FROM log_archive;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET last_row=1;
    
  OPEN c1;
  MainLoop:
  LOOP
      FETCH c1 INTO l_rec_id;
      IF last_row THEN
        LEAVE MainLoop;
      END IF;
      IF purge_due(l_rec_id) THEN
        DELETE FROM log_archive WHERE rec_id=l_rec_id;
        SET delete_count=delete_count+1;
        IF MOD(delete_count,100)=0 THEN
           COMMIT;
        END IF;
      END IF;
  END LOOP MainLoop;
  CLOSE c1;
  
END;
