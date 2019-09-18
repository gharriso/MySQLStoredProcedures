CREATE PROCEDURE book_details (
  in_start_date DATE,
  in_end_date   DATE)
BEGIN
  DECLARE  v_title, v_author VARCHAR(60);
  DECLARE  v_last_book,  v_book_id INT DEFAULT 0;

  DECLARE book_cur CURSOR FOR
      SELECT book_id,title,author
        FROM books
       WHERE date_published BETWEEN in_start_date
                 AND in_end_date;

  OPEN book_cur;
  book_loop:LOOP
    FETCH book_cur INTO  v_book_id, v_title, v_author;
    IF  v_last_book THEN LEAVE book_loop; END IF;

    CALL details_show( v_title, v_author);
    CALL update_borrow_history ( v_book_id);
  END LOOP;
END$$
