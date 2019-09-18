CREATE TRIGGER employees_bu
     BEFORE UPDATE
     ON employees
  	FOR EACH ROW
  BEGIN
    DECLARE  v_18k_contrib NUMERIC(4,2);

    IF NEW.salary <20000 THEN
      SET NEW.contrib_18k=0;
    ELSEIF NEW.salary <40000 THEN
      SET NEW.contrib_18k=NEW.salary*.015;
    ELSEIF NEW.salary<55000 THEN
      SET NEW.contrib_18k=NEW.salary*.02;
    ELSE
      SET NEW.contrib_18k=NEW.salary*.025;
    END IF;
  END$$

CREATE FUNCTION emp18k_contrib(in_salary NUMERIC(10,2))
  RETURNS INT
    DETERMINISTIC 
BEGIN
  DECLARE  v_contrib NUMERIC(10,2);
  IF in_salary <20000 THEN
    SET  v_contrib=0;
  ELSEIF in_salary <40000 THEN
    SET  v_contrib=in_salary*.015;
  ELSEIF in_salary<55000 THEN
     SET  v_contrib=in_salary*.02;
  ELSE
     SET  v_contrib=in_salary*.025;
  END IF;

  RETURN( v_contrib);
END;
