DELIMITER $$

CREATE TRIGGER sales_bi_trg
  BEFORE INSERT ON sales
  FOR EACH ROW
BEGIN
  DECLARE row_count INTEGER;

  SELECT COUNT(*)
    INTO row_count
    FROM customer_sales_totals
   WHERE customer_id=NEW.customer_id;

  IF row_count > 0 THEN
    UPDATE customer_sales_totals
       SET sale_value=sale_value+NEW.sale_value
     WHERE customer_id=NEW.customer_id;
  ELSE
    INSERT INTO customer_sales_totals
       (customer_id,sale_value)
      VALUES(NEW.customer_id,NEW.sale_value);
  END IF;

END$$

CREATE TRIGGER sales_bu_trg
  BEFORE UPDATE ON sales
  FOR EACH ROW
BEGIN

  UPDATE customer_sales_totals
     SET sale_value=sale_value+(NEW.sale_value-OLD.sale_value)
   WHERE customer_id=NEW.customer_id;

END$$

CREATE  TRIGGER sales_bd_trg
  BEFORE DELETE ON sales
  FOR EACH ROW
BEGIN

  UPDATE customer_sales_totals
     SET sale_value=sale_value-OLD.sale_value
   WHERE customer_id=OLD.customer_id;

END$$
