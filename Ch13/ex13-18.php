   $query  = "call stored_proc_with_2_results( $employee_id )";
   if ($mysqli->multi_query($query)) {

      $result = $mysqli->store_result();
      while ($row = $result->fetch_object()) {
         printf("%d %s %s\n",$row->employee_id,$row->surname,$row->firstname);
      }
      $mysqli->next_result();
      $result = $mysqli->store_result();
      while ($row = $result->fetch_object()) {
         printf("%d %s \n",$row->customer_id,$row->customer_name);
      }
   }
