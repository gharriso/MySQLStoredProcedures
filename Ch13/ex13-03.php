   $sql="SELECT employee_id, surname, salary
           FROM employees
          WHERE salary>95000
            AND department_id=1
	         AND status='G'";
            
   $results=$mysqli->query($sql);
	if ($mysqli->errno) { die ($mysqli->errno." ".$mysqli->error); }
   while($row=$results->fetch_object())      {
         printf("%d\t%s\t%d\n",$row->employee_id,$row->surname,$row->salary);
   }
