		IF (percentage<75) THEN
			SET LessThan75=LessThan75+1;
		ELSEIF (percentage >=75 AND percentage<90) THEN
			SET Range75to89=Range75to89+1;
		ELSEIF (percentage >=90 and percentage <=95) THEN
			SET Range90to95=Range90to95+1;
		ELSE
			SET Above95=Above95+1;
		END IF;
