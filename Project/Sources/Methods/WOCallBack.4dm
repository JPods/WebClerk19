//%attributes = {}
C_TEXT:C284($myWindow)

Case of 
	: ([WorkOrder:66]DTCompleted:6=0)
		$0:="Pending"
		
		
	: ([WorkOrder:66]DTCompleted:6#0)
		jDateTimeRecov([WorkOrder:66]DTCompleted:6; ->vDate1)
		$0:=String:C10(vDate1)
	: (myOK=3)
		
		
	: (myOK=4)
		
		
	: (myOK=5)
		
		
End case 