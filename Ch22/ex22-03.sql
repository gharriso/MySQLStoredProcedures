CREATE PROCEDURE sales_summary()
    READS SQL DATA
BEGIN

        DECLARE SumSales    FLOAT DEFAULT 0;
        DECLARE SumSquares  FLOAT DEFAULT 0;
        DECLARE NValues     INT   DEFAULT 0;
        DECLARE SaleValue   FLOAT DEFAULT 0;
        DECLARE Mean        FLOAT;
        DECLARE StdDev      FLOAT;

        DECLARE last_sale INT DEFAULT 0;

        DECLARE sale_csr CURSOR FOR
         SELECT sale_value FROM SALES s
          WHERE sale_date >date_sub(curdate(),INTERVAL 6 MONTH);

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET last_sale=1;

        OPEN sale_csr;
        sale_loop: LOOP
            FETCH sale_csr INTO SaleValue;
            IF last_sale=1 THEN LEAVE sale_loop; END IF;

            SET NValues=NValues+1;
            SET SumSales=SumSales+SaleValue;
      			SET SumSquares=SumSquares+POWER(SaleValue,2);

        END LOOP sale_loop;
        CLOSE sale_csr;

        SET StdDev = SQRT((SumSquares - (POWER(SumSales,2) / NValues)) / NValues);
        SET Mean = SumSales / NValues;

        SELECT CONCAT('Mean=',Mean,' StdDev=',StdDev);

END
