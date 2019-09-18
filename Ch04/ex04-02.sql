CREATE PROCEDURE nested_blocks3()
BEGIN
        DECLARE my_variable VARCHAR(20);
        SET my_variable='This value was set in the outer block';
        BEGIN
                DECLARE my_variable VARCHAR(20);
                SET my_variable='This value was set in the inner block';
        END;
        SELECT my_variable, 'Can''t see changes made in the inner block';
END;
