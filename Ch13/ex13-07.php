   $sql="SELECT employee_id,surname,firstname
           FROM employees
          WHERE department_id=?
            AND status=?
          LIMIT 5";
   $stmt = $mysqli->prepare($sql);
   if ($mysqli->errno<>0) {die($mysqli->errno.": ".$mysqli->error);}
   
   $stmt->bind_param("is",$input_department_id,$input_status) or die($stmt-error);
   $stmt->bind_result( $employee_id,$surname,$firstname )  or die($stmt->error);

   $input_department_id=1;
   $input_status='G';
   $stmt->execute();	
   if ($mysqli->errno<>0) {die($stmt.errno.": ".$stmt->error) ;}
   while ($stmt->fetch()) {
         printf("%s %s %s\n", $employee_id,$surname,$firstname);
   }
