CREATE PROCEDURE getEvent (in_event_id INTEGER)
BEGIN
  SELECT event_id, title, event_date
    FROM events
   WHERE event_id = in_event_id;

END;
