If (vHere=2)
	C_LONGINT:C283($selRec; $recordNum)
	If (Modified record:C314([CallReport:34]))
		SAVE RECORD:C53([CallReport:34])
	End if 
	Case of 
		: ([CallReport:34]tableNum:2=2)
			
			If ([Customer:2]customerID:1#[CallReport:34]customerID:1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[CallReport:34]customerID:1)
			End if 
			If (Records in selection:C76([Customer:2])=1)
				$recordNum:=Record number:C243([Customer:2])
				ProcessTableOpen(Table:C252(->[Customer:2])*-1)
				READ ONLY:C145([Customer:2])
				GOTO RECORD:C242([Customer:2]; $recordNum)
			Else 
				BEEP:C151
				BEEP:C151
			End if 
		: ([CallReport:34]tableNum:2=48)
			If (String:C10([Lead:48]idNum:32)#[CallReport:34]customerID:1)
				QUERY:C277([Lead:48]; [Lead:48]idNum:32=Num:C11([CallReport:34]customerID:1))
			End if 
			If (Records in selection:C76([Lead:48])=1)
				$recordNum:=Record number:C243([Lead:48])
				ProcessTableOpen(Table:C252(->[Lead:48])*-1)
				READ ONLY:C145([Lead:48])
				GOTO RECORD:C242([Lead:48]; $recordNum)
			Else 
				BEEP:C151
				BEEP:C151
			End if 
		: ([CallReport:34]tableNum:2=13)
			If (String:C10([Contact:13]idNum:28)#[CallReport:34]customerID:1)
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([CallReport:34]customerID:1))
			End if 
			If (Records in selection:C76([Contact:13])=1)
				
				$recordNum:=Record number:C243([Contact:13])
				ProcessTableOpen(Table:C252(->[Contact:13])*-1)
				READ ONLY:C145([Contact:13])
				GOTO RECORD:C242([Contact:13]; $recordNum)
			Else 
				BEEP:C151
				BEEP:C151
			End if 
	End case 
Else 
	ALERT:C41("In CallReport from primary record"+<>vCR+"Save/Close CallReport to see primary record.")
End if 