CREATE TRIGGER sales_bi_trg
  BEFORE INSERT ON sales
  FOR EACH ROW
  SET @x=NEW.sale_value;
