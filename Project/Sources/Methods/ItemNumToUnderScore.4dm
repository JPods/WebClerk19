//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/26/20, 20:37:00
// ----------------------------------------------------
// Method: ItemNumToUnderScore
// Description
// 
//
// Parameters
// ----------------------------------------------------

// _FIX_ITEMNUMS
allowAlerts_boo:=False:C215
ALL RECORDS:C47([Item:4])
ARRAY LONGINT:C221(ALONGINT11; 0)
SELECTION TO ARRAY:C260([Item:4]; ALONGINT11)
REDUCE SELECTION:C351([Item:4]; 0)
vi2:=Size of array:C274(ALONGINT11)
For (vi1; 1; vi2)
	GOTO RECORD:C242([Item:4]; ALONGINT11{vi1})
	srItemNum:=Replace string:C233([Item:4]itemNum:1; "-"; "_")
	If (srItemNum#[Item:4]itemNum:1)
		VBOOLEAN1:=ConsolidateRecs(->[Item:4]; ->[Item:4]itemNum:1; ->srItemNum)
		[Item:4]itemNum:1:=srItemNum
		SAVE RECORD:C53([Item:4])
	End if 
End for 
ALERT:C41("All items - converted to _")
allowAlerts_boo:=True:C214