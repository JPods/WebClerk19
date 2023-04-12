//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/21/11, 17:51:55
// ----------------------------------------------------
// Method: TerritoryApplyByZip
// Description
// 
//
// Parameters
// ----------------------------------------------------
QUERY:C277([Customer:2]; [Customer:2]zip:8>=[Territory:25]beginningZip:4; *)
QUERY:C277([Customer:2];  & [Customer:2]zip:8<=[Territory:25]endingZip:5)
C_LONGINT:C283($i; $k; $lockedCount)
$k:=Records in selection:C76([Customer:2])
FIRST RECORD:C50([Customer:2])
CREATE EMPTY SET:C140([Customer:2]; "Current")
For ($i; 1; $k)
	If (Locked:C147([Customer:2]))
		$lockedCount:=$lockedCount+1
		ADD TO SET:C119([Customer:2]; "Current")
	Else 
		[Customer:2]territoryid:120:=[Territory:25]territoryid:3
		[Customer:2]repID:58:=[Territory:25]repID:2
		[Customer:2]salesNameID:59:=[Territory:25]salesNameID:1
		SAVE RECORD:C53([Customer:2])
	End if 
	NEXT RECORD:C51([Customer:2])
End for 
REDUCE SELECTION:C351([Customer:2]; 0)
USE SET:C118("Current")
CLEAR SET:C117("Current")
If (Records in selection:C76([Customer:2])>0)
	DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "Territory Range: "+[Territory:25]beginningZip:4+"->"+[Territory:25]endingZip:5)
End if 
