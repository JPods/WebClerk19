
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/19/17, 15:26:38
// ----------------------------------------------------
// Method: [Item].Input1.Variable20
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Record number:C243([Item:4])>-1)
	ItemNumChange(srItemNum)
Else 
	[Item:4]itemNum:1:=srItemNum
End if 
