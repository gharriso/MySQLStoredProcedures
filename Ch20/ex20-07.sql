SELECT publisher, 
       SUM(quantity_in_stock) on_hand_quantity,
       SUM(quantity_in_stock*wholesale_price) on_hand_value,             
       SUM(books_on_order) books_on_order,         
       SUM(books_on_order*wholesale_price) order_value    
  FROM book_catalog   
 GROUP by publisher
