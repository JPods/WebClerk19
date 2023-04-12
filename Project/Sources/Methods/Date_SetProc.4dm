//%attributes = {"publishedWeb":true}
//Procedure: Date_SetProc
Process_ListActive
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(<>aPrsNum)
For ($i; 1; $k)
	BRING TO FRONT:C326(<>aPrsNum{$i})
	Date_Set
End for 