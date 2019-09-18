	WHILE (i<=1000) DO
		SET rooti=sqrt(i);
		SET j=1;
		WHILE (j<=5000) DO
        		SET rootj=sqrt(j);
			SET sumroot=sumroot+rootj+rooti;
			SET j=j+1;
		END WHILE;
		SET i=i+1;
	END WHILE;
