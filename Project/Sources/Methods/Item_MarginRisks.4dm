//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-01T00:00:00, 09:53:27
// ----------------------------------------------------
// Method: Item_MarginRisks
// Description
// Modified: 07/01/13
// 
// 
//
// Parameters
// ----------------------------------------------------

CREATE EMPTY SET:C140([Item:4]; "current")
vi2:=Records in selection:C76([Item:4])
For (vi1; 1; vi2)
	GOTO SELECTED RECORD:C245([Item:4]; vi1)
	If ([Item:4]priceB:3<(2*[Item:4]costAverage:13))
		ADD TO SET:C119([Item:4]; "current")
	End if 
End for 
UNLOAD RECORD:C212([Item:4])
USE SET:C118("current")
CLEAR SET:C117("current")
DB_ShowCurrentSelection(->[Item:4])