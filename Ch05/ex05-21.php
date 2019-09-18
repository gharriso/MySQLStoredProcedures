
<h1>Department listing</h1>
<table border="1" width="90%">
   <tr> <td><b>Department ID</b></td>
        <td><b>Department Name</b></td>
<?php
   $hostname="localhost";
   $username="root";
   $password="secret";
   $database="sqltune";
   
   $p1="";
   $p2="";
    

   $dbh = new mysqli($hostname, $username, $password, $database);

   /* check connection */
   if (mysqli_connect_errno()) {
      printf("Connect failed: %s\n", mysqli_connect_error());
      exit();
   }

   if ($result_set = $dbh->query("call department_list()"))
   {
      printf('');
      while($row=$result_set->fetch_object())
      {
         printf("<tr><td>%s</td><td>%s</td></tr>\n",
                  $row->department_id, $row->department_name);
      }
   }
   else // Query failed - show error
   {
      printf("<p>Error retrieving stored procedure result set:%d (%s) %s\n",
             mysqli_errno($dbh),mysqli_sqlstate($dbh),mysqli_error($dbh));
      $dbh->close();
      exit();
   }  
   /* free result set */
   $result_set->close();
   $dbh->close();
   
?>
</table>  
</body>
</html> 
