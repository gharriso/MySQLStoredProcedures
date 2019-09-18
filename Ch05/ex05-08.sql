
DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_last_row_fetched=1;
	
SET l_last_row_fetched=0;
OPEN cursor1;
cursor_loop:LOOP
	FETCH cursor1 INTO l_customer_name,l_contact_surname,l_contact_firstname;
	IF l_last_row_fetched=1 THEN
		LEAVE cursor_loop;
	END IF;
	/*Do something with the row fetched*/
END LOOP cursor_loop;
CLOSE cursor1;
SET l_last_row_fetched=0;
