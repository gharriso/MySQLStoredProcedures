SELECT departments.department_name,employee_id,surname,firstname   
  FROM departments    
       JOIN employees   
       USING (department_id)  
 WHERE employees.date_of_birth<date_sub(curdate(),interval 55 year) 
