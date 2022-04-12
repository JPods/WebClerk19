// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/18/11, 16:45:23
// ----------------------------------------------------
// Method: Object Method: b1
// Description
// 
//
// Parameters
// ----------------------------------------------------

ARRAY LONGINT:C221(aLongint1; 0)
CREATE EMPTY SET:C140([Customer:2]; "Current")
C_LONGINT:C283($i; $k; $lockedCount)
FIRST RECORD:C50([Territory:25])
$k:=Records in selection:C76([Territory:25])
For ($i; 1; $k)
	QUERY:C277([Customer:2]; [Customer:2]zip:8>=[Territory:25]beginningZip:4; *)
	QUERY:C277([Customer:2];  & [Customer:2]zip:8<=[Territory:25]endingZip:5)
	SELECTION TO ARRAY:C260([Customer:2]; aLongint1)
	CREATE SET FROM ARRAY:C641([Customer:2]; aLongint1; "Temp")
	UNION:C120("Current"; "Temp"; "Current")
	NEXT RECORD:C51([Territory:25])
End for 
UNLOAD RECORD:C212([Territory:25])
USE SET:C118("Current")
CLEAR SET:C117("Current")
DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "Territory Range: Customers List")


CREATE EMPTY SET:C140([Lead:48]; "Current")
C_LONGINT:C283($i; $k; $lockedCount)
FIRST RECORD:C50([Territory:25])
$k:=Records in selection:C76([Territory:25])
For ($i; 1; $k)
	QUERY:C277([Lead:48]; [Lead:48]zip:10>=[Territory:25]beginningZip:4; *)
	QUERY:C277([Lead:48];  & [Lead:48]zip:10<=[Territory:25]endingZip:5)
	SELECTION TO ARRAY:C260([Lead:48]; aLongint1)
	CREATE SET FROM ARRAY:C641([Lead:48]; aLongint1; "Temp")
	UNION:C120("Current"; "Temp"; "Current")
	NEXT RECORD:C51([Territory:25])
End for 
UNLOAD RECORD:C212([Territory:25])
USE SET:C118("Current")
CLEAR SET:C117("Current")
DB_ShowCurrentSelection(->[Lead:48]; ""; 1; "Territory Range: Leads List")