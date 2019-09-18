CREATE FUNCTION isodd(input_number int) 
       RETURNS int 
BEGIN 
        DECLARE v_isodd INT; 
 
        IF MOD(input_number,2)=0 THEN 
                SET v_isodd=FALSE; 
        ELSE 
                SET v_isodd=TRUE; 
        END IF; 
 
        RETURN(v_isodd); 
 
END ;
