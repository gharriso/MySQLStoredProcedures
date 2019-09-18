CREATE PROCEDURE example1()
BEGIN
  DECLARE l_book_count INTEGER;

  SELECT COUNT(*)
    INTO l_book_count
    FROM books
   WHERE author LIKE '%HARRISON,GUY%';

  SELECT CONCAT('Guy has written (or co-written) ',
         l_book_count ,
         ' books.');

   -- Oh, and I changed my name, so...
   UPDATE books
      SET author = REPLACE (author, 'GUY', 'GUILLERMO')
    WHERE author LIKE '%HARRISON,GUY%';

END
