CREATE FUNCTION f_discount_price
     (normal_price NUMERIC(8,2))
   RETURNS NUMERIC(8,2)
BEGIN

    DECLARE discount_price NUMERIC(8,2);

    IF (normal_price>500) THEN
       SET discount_price=normal_price*.8;

    ELSEIF (normal_price>100) THEN
       SET discount_price=normal_price*.9;

    ELSE
       SET discount_price=normal_price;

    END IF;

    RETURN(discount_price);

END;
