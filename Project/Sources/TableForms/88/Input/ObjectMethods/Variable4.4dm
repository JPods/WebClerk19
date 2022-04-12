C_LONGINT:C283($curRecNum; $masterRecNum)
If ([LoadTag:88]ideSuperior:27>0)
	$masterRecNum:=[LoadTag:88]ideSuperior:27
	PUSH RECORD:C176([LoadTag:88])
	QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=$masterRecNum)
	ProcessTableOpen(Table:C252(->[LoadTag:88])*-1)
	POP RECORD:C177([LoadTag:88])
Else 
	ALERT:C41("There is no master package.")
End if 