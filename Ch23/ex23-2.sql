CREATE PROCEDURE weekly_check (
   in_isbn   VARCHAR(20),
   in_author VARCHAR(60)
)
     
BEGIN
   DECLARE  v_count INT;
   DECLARE  v_counter INT;
   DECLARE  v_available INT;
   DECLARE  v_new_location INT DEFAULT 1056;
   DECLARE  v_published_date DATE DEFAULT NOW();

   SET  v_published_date=book_published_date(in_isbn);

   IF DATE_SUB(NOW(), INTERVAL 60 DAY) >  v_published_date THEN
      CALL review_usage();
   ELSEIF DATE_SUB(NOW(), INTERVAL 24 DAY) >  v_published_date
   THEN
      CALL check_availability (in_isbn,  v_available,  v_count);
       IF  v_available
         AND /* Turn off due to Req A12.6 */ FALSE
      THEN
         CALL transfer_book (in_isbn,  v_count - 1,  v_new_location);
      END IF;
   -- Check for reserves
   -- CALL analyze_requests (isbn_in);
   END IF;
END$$
