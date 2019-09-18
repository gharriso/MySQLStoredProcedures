CREATE TABLE SALES2000 TYPE=MYISAM AS 
SELECT *
  FROM sales 
 WHERE sale_date BETWEEN '2000-01-01' AND '2000-12-31';
 
CREATE TABLE SALES2001 TYPE=MYISAM as 
SELECT *
  FROM sales 
 WHERE sale_date BETWEEN '2001-01-01' AND '2001-12-31';
 
 . . . Create other "year" tables . . .
CREATE TABLE all_sales  
   (sales_id     INT(8)   NOT NULL PRIMARY KEY, 
    . . . Other column definitions . . . 
    Gst_flag     NUMERIC(8,0))  
 TYPE=MERGE    
 UNION=(sales_pre_2000,sales2001,sales2002,
        sales2003,sales2004,sales2005,sales2006)
 INSERT_METHOD=LAST ;
