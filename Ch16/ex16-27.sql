CREATE PROCEDURE randomizer(INOUT a_number FLOAT)
  NOT DETERMINISTIC NO SQL
  SET a_number=RAND()*a_number;
