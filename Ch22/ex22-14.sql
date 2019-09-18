		IF (percentage>95) THEN
			SET Above95=Above95+1;
		ELSEIF (percentage >=90) THEN
			SET Range90to95=Range90to95+1;
		ELSEIF (percentage >=75) THEN
			SET Range75to89=Range75to89+1;
		ELSE
			SET LessThan75=LessThan75+1;
		END IF;
