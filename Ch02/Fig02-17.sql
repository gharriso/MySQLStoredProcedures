CREATE TRIGGER sales_bi_trg
	BEFORE INSERT ON sales
	FOR EACH ROW
BEGIN
	IF NEW.sale_value > 500 THEN
	   SET NEW.free_shipping='Y';
	ELSE
	   SET NEW.free_shipping='N';
	END IF;
	IF NEW.sale_value > 1000 THEN
	   SET NEW.discount=NEW.sale_value*.15;
        ELSE
	   SET NEW.discount=0;
	END IF;
END;
