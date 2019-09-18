CREATE PROCEDURE getRecentEvents(in_event_date DATETIME)
BEGIN
  SELECT event_id AS EVENT_ID, title AS EVENT_TITLE, event_date AS EVENT_DATE
    FROM events
   WHERE event_date > in_event_date;
END;
