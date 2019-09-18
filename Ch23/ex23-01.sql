CREATE PROCEDURE display_book_usage()
  DETERMINISTIC
BEGIN
   DECLARE v_month INT;
   DECLARE v_x  INT;
   DECLARE yearly_analysis_csr CURSOR FOR SELECT …;
   DECLARE monthly_analysis_csr CURSOR FOR SELECT …;

   OPEN yearly_analysis_csr;
   yearly_analysis:
   LOOP
     FETCH yearly_analysis_csr INTO v_month;
     OPEN monthly_analysis_csr;
     monthly_analysis:
     LOOP
       FETCH monthly_analysis_csr INTO v_x;
	--Lots of monthly analysis code 
     END LOOP monthly_analysis;
--Lots of yearly analysis code 
END LOOP yearly_analysis;
