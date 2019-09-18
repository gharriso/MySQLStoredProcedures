select sum(`prod`.`sales`.`QUANTITY`) AS `SUM(quantity)`,
       sum(`prod`.`sales`.`SALE_VALUE`) AS `SUM(sale_value)` 
  from `prod`.`sales` 
 where ((`prod`.`sales`.`CUSTOMER_ID` = 1) 
   and (`prod`.`sales`.`PRODUCT_ID` = 1) 
   and (`prod`.`sales`.`SALE_DATE` between 20040101000000 and 20041231000000))

