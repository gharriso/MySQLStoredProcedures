CREATE PROCEDURE updateEvent
  (OUT row_count INTEGER, in_event_date DATETIME,
   in_title VARCHAR(60),  in_event_id INTEGER)
BEGIN
  UPDATE events
     SET title = in_title, event_date = in_event_date
   WHERE event_id = in_event_id;

  SET row_count = ROW_COUNT();
END $$

CREATE PROCEDURE deleteEvent(OUT row_count INTEGER, in_event_id INTEGER)
BEGIN
  DELETE FROM events
   WHERE event_id = in_event_id;

  SET row_count = ROW_COUNT();
END$$

CREATE PROCEDURE createEvent
  ( InEventDate DATE, InEventTitle VARCHAR(60), InEventId INT )
BEGIN
  INSERT INTO events (event_date, title, event_id)
   VALUES(InEventDate, CONCAT(InEventId, InEventTitle), InEventId);
END$$
