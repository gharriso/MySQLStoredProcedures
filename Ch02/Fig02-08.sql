drop procedure if exists discounted_price
$$
CREATE PROCEDURE discounted_price
    (normal_price NUMERIC(8,2),
     OUT discount_price NUMERIC(8,2))
    NO SQL
BEGIN
    IF (normal_price>500) THEN
       SET discount_price=normal_price*.8;

    ELSEIF (normal_price>100) THEN
       SET discount_price=normal_price*.9;

    ELSE
       SET discount_price=normal_price;

    END IF;

END;
$$