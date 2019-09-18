CREATE VIEW current_user_details_view AS 
        SELECT departments.department_name,employees.manager_id 
          FROM employees join departments using (department_id) 
         WHERE db_user=convert(SUBSTR(USER(),1,INSTR(USER(),'@')-1) using latin1) ;
				
CREATE VIEW employees_view as
     SELECT firstname,surname,salary,db_user,
       CASE  WHEN u.department_name='PAYROLL' OR u.manager_id IN (0,1) THEN
			       salary 
		    ELSE '0000000000'
	    END CASE AS salary 
  FROM employees e, current_user_details_view u ; 
