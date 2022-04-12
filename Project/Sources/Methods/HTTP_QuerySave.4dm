//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/26/10, 22:13:21
// ----------------------------------------------------
// Method: HTTP_QuerySave
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable)
$ptTable:=$1

[EventLog:75]tableName:39:=Table name:C256($ptTable)
[EventLog:75]lastQueryScript:31:=vURLQueryScript
[EventLog:75]wccEmail:33:=vURLSortScript
[EventLog:75]tableNumArray:44:=Table:C252($ptTable)
ARRAY LONGINT:C221($aRecNums; 0)
If (Records in selection:C76($ptTable->)>1)
	SELECTION TO ARRAY:C260($ptTable->; $aRecNums)
	VARIABLE TO BLOB:C532($aRecNums; [EventLog:75]recordArray:43)
	If (vURLQueryScript#"")
		[EventLog:75]lastQueryScript:31:=vURLQueryScript
	End if 
Else 
	ARRAY LONGINT:C221($aRecNums; 0)
	SET BLOB SIZE:C606([EventLog:75]recordArray:43; 0)
End if 
If ([EventLog:75]idNum:5#0)
	SAVE RECORD:C53([EventLog:75])
End if 

If (False:C215)  // recovery of data Line41 Http_NavServer
	ARRAY LONGINT:C221($aRecNums; 0)
	BLOB TO VARIABLE:C533([EventLog:75]recordArray:43; $aRecNums)
	CREATE SELECTION FROM ARRAY:C640([Item:4]; $aRecNums)
	ARRAY LONGINT:C221($aRecNums; 0)
End if 