  #Preparing the statment
  $insert_stmt=$mysqli->prepare("INSERT INTO x VALUES(?,?)") 
      or die($mysqli->error);
  #associate variables with the input parameters
  $insert_stmt->bind_param("is", $my_number,$my_string); #i=integer
  #Execute the statement multiple times....
  for ($my_number = 1; $my_number <= 10; $my_number++) {
      $my_string="row ".$my_number;
      $insert_stmt->execute() or die ($insert_stmt->error);
  }
  $insert_stmt->close();
