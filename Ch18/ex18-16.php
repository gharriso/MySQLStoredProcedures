  $department = $_POST['department'];
  $sql="CALL emps_in_dept( $department )";
  if ($result_set = $dbh->query($sql)) {
    $table =new HTML_Table('border=1'); 
    $table->addRow(array('ID','Surname','Firstname'));
    $table->setRowAttributes(0,array("bgcolor" => "silver"));
    while ($row = $result_set->fetch_row()) {
      $table->addRow(array($row[0],$row[1],$row[2]));
    }
    print $table->toHtml();
