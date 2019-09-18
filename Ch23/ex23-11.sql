CREATE PROCEDURE assign_workload()
BEGIN /*main*/
  DECLARE  v_last_row INT DEFAULT 0;
  DECLARE  v_case_id, v_telesales_id, v_department_id  INT;

  DECLARE telesales_cur CURSOR FOR
    SELECT telesales_id,department_id FROM telesales;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET  v_last_row=1;

  OPEN telesales_cur;
  ts_loop:LOOP
    FETCH telesales_cur INTO  v_telesales_id, v_department_id;
    IF  v_last_row THEN LEAVE ts_loop; END IF;

    IF analysis_caseload( v_telesales_id)<
       analysis_avg_cases( v_department_id) THEN

       SET  v_case_id=assign_next_open_case( v_telesales_id);
       CALL schedule_case( v_case_id);
    END IF;
  END LOOP;
  CLOSE telesales_cur;
  SET  v_last_row=0;

END$$
