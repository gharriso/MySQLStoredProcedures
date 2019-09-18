CREATE TRIGGER employees_trg_bu
     BEFORE UPDATE ON employees
     FOR EACH ROW
  BEGIN
    IF NEW.salary <50000 THEN
      SET NEW.contrib_401K=500;
    ELSE
      SET NEW.contrib_401K=500+(NEW.salary-50000)*.01;
    END IF;
  END
