SELECT CONCAT(trigger_schema,'.',trigger_name) AS trigger_name,
       CONCAT_WS(' ',action_timing,event_manipulation,
                 ' OF ',event_object_table) AS trigger_event,
       action_statement
  FROM information_schema.triggers;