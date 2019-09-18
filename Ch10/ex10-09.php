   $stmt=$my_db->prepare("SELECT isodd(?)") or die($my_db->error);
   
   $stmt->bind_param('i',$aNumber) or die($stmt->error); 
   
   $stmt->execute() or die($stmt->error);
   
   $stmt->bind_result($isodd);
   
   $stmt->fetch();
   
   if ($isodd == 1 )
      printf("%d is an odd number\n",$aNumber);
   else
      printf("%d is an even number\n",$aNumber); 
