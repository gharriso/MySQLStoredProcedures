  # Create a connection
<?php
	$mysqli = new mysqli("localhost", "root", "secret", "test");
	if (mysqli_connect_errno()) {
		printf("Connect failed: %s\n", mysqli_connect_error());
		exit ();
	} else {
		printf("Connect succeeded\n");
	}
?>
