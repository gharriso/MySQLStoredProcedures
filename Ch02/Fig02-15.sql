CREATE PROCEDURE call_example
    (employee_id INT, employee_type VARCHAR(20))
    NO SQL
BEGIN
    DECLARE l_bonus_amount NUMERIC(8,2);

    IF employee_type='MANAGER' THEN
       CALL calc_manager_bonus(employee_id ,l_bonus_amount);
    ELSE
       CALL calc_minion_bonus(employee_id,l_bonus_amount);
    END IF;
    CALL grant_bonus(employee_id,l_bonus_amount);
END;