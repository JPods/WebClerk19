//%attributes = {"publishedWeb":true}
If (<>prcControl=1)
	<>prcControl:=0
	WindowOpenTaskOffSets
	Process_InitLocal
	ptCurTable:=(->[Control:1])
Else 
	REDUCE SELECTION:C351([Order:3]; 0)
End if 
Process_AddRecord("Invoice")