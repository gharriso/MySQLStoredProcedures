CREATE PROCEDURE nested_blocks1()
BEGIN
        DECLARE outer_variable VARCHAR(20);
        BEGIN
                DECLARE inner_variable VARCHAR(20);
                SET inner_variable='This is my private data';
        END;
        SELECT inner_variable,' This statement causes an error ';

END 