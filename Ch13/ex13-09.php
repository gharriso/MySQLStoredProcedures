   require_once "HTML/Table.php";
   $table =new HTML_Table('border=1'); 

   $stmt=$mysqli->prepare($sql);
   if ($mysqli->errno) {die($mysqli->errno.": ".$mysqli->error);}
 
   # Retrieve meta-data and print table headings
   $metadata = $stmt->result_metadata();
   $field_cnt = $metadata->field_count;
   $colnames=array();
   while ($colinfo = $metadata->fetch_field()) {
      array_push($colnames,$colinfo->name);
   }
   $table->addRow($colnames);
   $table->setRowAttributes(0,array("bgcolor" => "silver"));

    
   # Declare an array to receive column data
   $stmt_results=array_fill(0,$field_cnt,'');
   # Set first element of the bind_result parameter as the statement handle
   $bind_result_parms[0]=$stmt;
   # Add the references to the column arrays to the parameter list
   for ($i=0;$i<$field_cnt;$i++)   {
      array_push($bind_result_parms,  &$stmt_results[$i]);
   }
   #Pass the array to the bind_result function
   call_user_func_array("mysqli_stmt_bind_result", $bind_result_parms);
   $stmt->execute();
   $row=0;
   while($stmt->fetch())   {
      $row++;
      for ($i=0;$i<$field_cnt;$i++)   {
         $table->setCellContents($row,$i,$stmt_results[$i]);
      }
   }
   $stmt->close();
   print $table->toHtml();  
