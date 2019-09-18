   $query  = "call stored_proc_with_2_results( $employee_id )";
   if ($mysqli->multi_query($query)) {
   do {
        if ($result = $mysqli->store_result()) {
            while ($finfo = $result->fetch_field()) {
              printf("%s\t", $finfo->name);
            }
            printf("\n");
            
            while ($row = $result->fetch_row()) {
               for ($i=0;$i<$result->field_count;$i++) {
                  printf("%s\t", $row[$i]);
               }
               printf("\n");
           }
           $result->close();
       }
    } while ($mysqli->next_result());
