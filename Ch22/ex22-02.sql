PROCEDURE N_PRIMES
   ( p_num number)
   IS
   
	i INT;
	j INT;
	nprimes INT;
	isprime INT;
	
BEGIN
	
	i:=2;
	nprimes:=0;
	
	<<main_loop>>
	WHILE (i<p_num) LOOP
		isprime:=1;
		j:=2;
		<<divisor_loop>>
		WHILE (j<i) LOOP
			IF (MOD(i,j)=0) THEN
				isprime:=0;
				EXIT divisor_loop;
			END IF;
			j:=j+1;
		END LOOP ;
		IF (isprime=1) THEN
			nprimes:=nprimes+1;
		END IF;
		i:=i+1;
	END LOOP;
	dbms_output.put_line(nprimes||' prime numbers less than '||p_num);
END;
