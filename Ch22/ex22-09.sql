	WHILE (i<=1000) DO
		SET j=1;
		WHILE (j<=5000) DO
        		SET rooti=sqrt(i);
        		SET rootj=sqrt(j);
			SET sumroot=sumroot+rooti+rootj;
			SET j=j+1;
		END WHILE;
		SET i=i+1;
	END WHILE;
