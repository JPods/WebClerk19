TechNotesFor("Item")
If (Records in selection:C76([TechNote:58])>0)
	C_LONGINT:C283($found)
	TN_Dialog
	C_LONGINT:C283($found)
	$found:=Prs_CheckRunnin("TechNotes")
	C_TEXT:C284(<>vTN_OutSide)
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 120)
	Until (<>prcControl=0)
	<>vTN_OutSide:=[Item:4]itemNum:1
	POST OUTSIDE CALL:C329(<>aPrsNum{$found})
End if 