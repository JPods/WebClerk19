C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		
	: ($formEvent=On Double Clicked:K2:5)
		
		ONE RECORD SELECT:C189([Proposal:42])
		ProcessTableOpen(Table:C252(->[Proposal:42])*-1)
		DELAY PROCESS:C323(Current process:C322; 30)
		Case of 
			: (ptCurTable=(->[Project:24]))
				QUERY:C277([Proposal:42]; [Proposal:42]projectNum:22=[Project:24]projectNum:1)
		End case 
End case 