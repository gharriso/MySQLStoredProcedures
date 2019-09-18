CREATE PROCEDURE check_for_primes(in_limit INT)
BEGIN
  DECLARE i INT DEFAULT 2;
  DECLARE j INT DEFAULT 1;
  DECLARE n_primes INT DEFAULT 0;
  DECLARE is_prime INT DEFAULT 0;

  REPEAT

     -- See if i is a prime number
    SET j=2;
    SET is_prime=1;
    divisors: WHILE(j< i) DO
      IF MOD(i,j)=0 THEN
         SET is_prime=0;
         LEAVE divisors;
      END IF;
      SET j=j+1;
    END WHILE;

    IF is_prime THEN
      SET n_primes=n_primes+1;
    END IF;

    -- Move onto the next number
    IF (MOD(i,2)=0) THEN
      SET i=i+1;
    ELSE
      -- Next number is even, no need
      -- to check for it as a prime
      SET i=i+2;
    END IF;

  UNTIL (i=in_limit) END REPEAT;

  SELECT CONCAT(n_primes,' prime numbers <= ',in_limit);

END$$
