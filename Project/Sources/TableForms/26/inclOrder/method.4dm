C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		
	: ($formEvent=On Double Clicked:K2:5)
		
		ONE RECORD SELECT:C189([Invoice:26])
		ProcessTableOpen(Table:C252(->[Invoice:26])*-1)
		DELAY PROCESS:C323(Current process:C322; 30)
		Case of 
			: (ptCurTable=(->[Project:24]))
				QUERY:C277([Invoice:26]; [Invoice:26]projectNum:50=[Project:24]projectNum:1)
		End case 
End case 