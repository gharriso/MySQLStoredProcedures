CREATE PROCEDURE sp_add_location
         (in_location   VARCHAR(30),
          in_address1   VARCHAR(30),
          in_address2   VARCHAR(30),
          zipcode       VARCHAR(10))
    MODIFIES SQL DATA
BEGIN
   INSERT INTO locations
     (location,address1,address2,zipcode)
    VALUES
     (in_location,in_address1,in_address2,zipcode);
END
