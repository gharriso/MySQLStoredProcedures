<html>
<title>Employee Query</title>
<h1>Employee Query</h1>

<FORM ACTION="<?php echo $_SERVER['PHP_SELF']; ?>" METHOD=POST>
<p>Enter Department Id:
<input type="text" name="department" size="60">
<input type="submit" name="submit" value="submit"><p>
</form>

<?php
require_once "HTML/Table.php";


/*Check to see if user has hit submit*/
if (IsSet ($_POST['submit'])) {
  $dbh = new mysqli($hostname, $username, $password, $database);
  
  /* check connection */
  if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit ();
  }
  $sql="SELECT employee_id,surname,firstname FROM employees".
    "    WHERE department_id =".$_POST['department'];
  print $sql;
  if ($result_set = $dbh->query($sql)) {
      $table =new HTML_Table('border=1'); 
      $table->addRow(array('ID','Surname','Firstname'));
      $table->setRowAttributes(0,array("bgcolor" => "silver"));

    while ($row = $result_set->fetch_row()) {
      $table->addRow(array($row[0],$row[1],$row[2]));
    }
    print $table->toHtml();
  }
  else {
    printf("<p>Error retrieving stored procedure result set:%d (%s) %s\n",
	   mysqli_errno($dbh), mysqli_sqlstate($dbh), mysqli_error($dbh));
  }
  
}
$result_set->close();
$dbh->close();
?>
    
</body></html>
