<html><head><title>Employee listing</title><head><body>
<h1>Employee listing</h1>
<form method="post" >
<p>Enter Department ID:
<input type="text" name="dept_id" size="4">
<input type="submit" name="submit" value="submit"><p>
</form>

<?php
$hostname = "localhost";
$username = "root";
$password = "secret";
$database = "prod";

if (IsSet ($_POST['submit'])) {

	$dbh = new mysqli($hostname, $username, $password, $database);

	/* check connection */
	if (mysqli_connect_errno()) {
		printf("Connect failed: %s\n", mysqli_connect_error());
		exit ();
	}
	$dept_id = $_POST['dept_id'];

	if ($result_set = $dbh->query("call employee_list( $dept_id )")) {
		print ('<table border="1" width="30%"> <tr> '.
               '<td>Employee_id</td><td>Surname</td><td>Firstname</td></tr>');
		while ($row = $result_set->fetch_object()) {
			printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", 
			       $row->employee_id, $row->surname, $row->firstname);
		}
	} else {
		printf("<p>Error:%d (%s) %s\n", mysqli_errno($dbh), 
		       mysqli_sqlstate($dbh), mysqli_error($dbh));
	}
	print ("</table> ");
	$dbh->close();
}
?>
</body></html>


