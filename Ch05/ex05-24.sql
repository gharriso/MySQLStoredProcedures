CREATE PROCEDURE sp_issue_invoices()
   
BEGIN
  DECLARE l_sale_id INT;
  DECLARE l_last_sale INT DEFAULT 0;

  DECLARE sale_csr CURSOR FOR
    SELECT sales_id
      FROM overdue_sales_tmp;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_last_sale=1;

  CALL sp_overdue_sales();

  OPEN sale_csr;
  sale_loop:LOOP
    FETCH sale_csr INTO l_sale_id;
    IF l_last_sale THEN
      LEAVE sale_loop;
    END IF;
    CALL sp_issue_one_invoice(l_sale_id);
  END LOOP sale_loop;
  CLOSE sale_csr;

END;
