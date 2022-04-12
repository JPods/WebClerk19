//%attributes = {"publishedWeb":true}

C_DATE:C307($vdReset)
C_LONGINT:C283($vi1; $vi3; $vi3; $vi4; $vi5; $vi6; $vi7)
$vi2:=10000
For ($vi1; 1; $vi2)
	// (Random%(vEnd-vStart+1))+vStart
	// $vi5:=(Random%(25-3+1))+3  // between 3 and 25 (25 = 27 - 3 +1)
	$vi5:=(Random:C100%(28-1+1))+1  // between 1 and 28 (28 = 28 - 1 +1)
	If ($vi5>$vi7)
		$vi7:=$vi5
	End if 
	If ($vi5<$vi6)
		$vi6:=$vi5
	End if 
End for 