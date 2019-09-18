DELIMITER $$

DROP PROCEDURE IF EXISTS `prod`.`book_details` $$
CREATE DEFINER=`root`@`%` PROCEDURE `book_details`(  
  in_start_date DATE,  
  in_end_date   DATE)
    DETERMINISTIC
BEGIN  
  DECLARE l_title,l_author VARCHAR(60);  
  DECLARE l_last_book, l_book_id INT DEFAULT 0;  

  DECLARE book_cur CURSOR FOR  
      SELECT book_id,title,author  
        FROM books  
       WHERE date_published BETWEEN in_start_date  
                 AND in_end_date;  

  OPEN book_cur;  
  book_loop:LOOP
    FETCH book_cur INTO l_book_id,l_title,l_author;  
    IF l_last_book THEN LEAVE book_loop; END IF;  

    CALL details_show(l_title,l_author);
    CALL update_borrow_history (l_book_id);
  END LOOP;  
END $$

DELIMITER ;