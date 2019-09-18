CREATE PROCEDURE  function_example()
BEGIN

  DECLARE TwentyYearsAgoToday DATE;
  DECLARE mystring VARCHAR(250);

  SET TwentyYearsAgoToday=DATE_SUB(curdate(), interval 20 year);
  
  SET mystring=CONCAT('It was ',TwentyYearsAgoToday,
      ' Sgt Pepper taught the band to play...');

  SELECT mystring;
    
  IF (CAST(SUBSTR(version(),1,3) AS DECIMAL(2,1)) <5.0) THEN
    SELECT 'MySQL versions earlier than 5.0 cannot run stored programs - you must be halucinating';
  ELSE 
    SELECT 'Thank goodness you are running 5.0 or higher!';  
  END IF;

END
