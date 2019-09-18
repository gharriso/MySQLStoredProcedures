SELECT departments.department_name,employee_id,surname,firstname   
  FROM (SELECT * FROM departments ) departments    
        JOIN (SELECT * FROM employees)    employees   
        USING (department_id)  
 WHERE employees.date_of_birth<DATE_SUB(curdate(),INTERVAL 55 YEAR) 
