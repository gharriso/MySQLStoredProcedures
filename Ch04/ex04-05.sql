
IF (INSTR(l_version_string,'alpha')>0) THEN
		SELECT 'Alpha release of MySQL';
	ELSEIF (INSTR(l_version_string,'beta')>0) THEN 
		SELECT 'Beta release of MySQL';
	ELSE
		SELECT 'Production release of MySQL';
END IF;
