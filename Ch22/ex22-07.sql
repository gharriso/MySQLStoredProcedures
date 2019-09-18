UPDATE customers c
   SET sales_rep_id = 
       (SELECT manager_id
          FROM employees
                WHERE surname = c.contact_surname
           AND firstname = c.contact_firstname
           AND date_of_birth = c.date_of_birth)
 WHERE (contact_surname, 
        contact_firstname, 
        date_of_birth) IN 
   (SELECT surname, firstname, date_of_birth
      FROM employees and );
