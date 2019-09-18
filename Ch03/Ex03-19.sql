CREATE PROCEDURE strict_test()
BEGIN

  DECLARE a INT;
  DECLARE b VARCHAR(20);
  DECLARE c INT;

  SET a=99;
  SET b="Bottles of beer on the wall";
  SET c=CONCAT(a," ",b);
  SELECT c;
END
