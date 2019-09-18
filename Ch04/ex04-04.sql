
CREATE PROCEDURE nested_blocks5()
 outer_block: BEGIN
        DECLARE l_status int;
        SET l_status=1;
        inner_block: BEGIN
                IF (l_status=1) THEN
                        LEAVE inner_block;
                END IF;
                SELECT 'This statement will never be executed';
        END inner_block;
        SELECT 'End of program';
END outer_block
