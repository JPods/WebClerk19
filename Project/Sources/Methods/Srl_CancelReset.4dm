//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aSrPendRec)
For ($i; 1; $k)
	GOTO RECORD:C242([ItemSerial:47]; aSrPendRec{$i})
	Case of 
		: ([ItemSerial:47]Status:8="PA")
			
		: ([ItemSerial:47]Status:8="PS")
			
		: ([ItemSerial:47]Status:8="PI")
			
		: ([ItemSerial:47]Status:8="PR")
			
	End case 
End for 