		divisor_loop:
		WHILE (j<i) DO  /* Look for a divisor */

			IF (MOD(i,j)=0) THEN
				SET isprime=0;   /* This number is not prime*/
			END IF;
			SET j=j+1;
		END WHILE ;
