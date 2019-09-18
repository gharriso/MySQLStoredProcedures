CREATE FUNCTION concat_example_ansi(
        in_title          VARCHAR(4),
        in_gender         CHAR(1),
        in_firstname      VARCHAR(20),
        in_middle_initial CHAR(1),
        in_surname        VARCHAR(20))

  RETURNS VARCHAR(60)
BEGIN
  DECLARE l_title               VARCHAR(4);
  DECLARE l_name_string         VARCHAR(60);

  IF ISNULL(in_title)  THEN
     IF in_gender='M' THEN
        SET l_title='Mr';
     ELSE
        SET l_title='Ms';
     END IF;
  END IF;

  IF ISNULL(in_middle_initial) THEN
     SET l_name_string=l_title||' '||in_firstname||' '||in_surname;
  ELSE
     SET l_name_string=l_title||' '||in_firstname||' '||
                          in_middle_initial||' '||in_surname;
  END IF;

  RETURN(l_name_string);
END;
