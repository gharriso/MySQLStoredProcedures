CREATE PROCEDURE sp_customer_search_dyn
    (in_customer_name VARCHAR(30),
     in_contact_surname VARCHAR(30),
     in_contact_firstname VARCHAR(30),
     in_phoneno VARCHAR(10))
  
BEGIN
  DECLARE l_where_clause VARCHAR(1000) DEFAULT 'WHERE';

  IF in_customer_name IS NOT NULL THEN
      SET l_where_clause=CONCAT(l_where_clause,
         ' customer_name="',in_customer_name,'"');
  END IF;

  IF in_contact_surname IS NOT NULL THEN
     IF l_where_clause<>'WHERE' THEN
        SET l_where_clause=CONCAT(l_where_clause,' AND ');
     END IF;
     SET l_where_clause=CONCAT(l_where_clause,
         ' contact_surname="',in_contact_surname,'"');
  END IF;

  IF in_contact_firstname IS NOT NULL THEN
     IF l_where_clause<>'WHERE' THEN
        SET l_where_clause=CONCAT(l_where_clause,' AND ');
     END IF;
     SET l_where_clause=CONCAT(l_where_clause,
         ' contact_firstname="',in_contact_firstname,'"');
  END IF;

  IF in_phoneno IS NOT NULL THEN
     IF l_where_clause<>'WHERE' THEN
        SET l_where_clause=CONCAT(l_where_clause,' AND ');
     END IF;
     SET l_where_clause=CONCAT(l_where_clause,
         ' phoneno="',in_phoneno,'"');
  END IF;

  SET @sql=CONCAT('SELECT * FROM customers ',
                  l_where_clause);


  PREPARE s1 FROM @sql;
  EXECUTE s1;
  DEALLOCATE PREPARE s1;

END;
