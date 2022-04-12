//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-07T00:00:00, 01:04:21
// ----------------------------------------------------
// Method: RP_OpenRecordRemote
// Description
// Modified: 10/07/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($userName; $password; $tableName; $title; $stringUniqueID; $tablename)
C_LONGINT:C283($uniqueID)
$suppression:=<>vlWildSrch
<>vlWildSrch:=1
$userName:=WCapi_GetParameter("userName"; "")
<>vlWildSrch:=$suppression

//
vResponse:="Failed: "
$password:=WCapi_GetParameter("password"; "")
QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$userName; *)  //find remote user record
QUERY:C277([RemoteUser:57];  & [RemoteUser:57]userPassword:3=$password)
FIRST RECORD:C50([RemoteUser:57])
If ([RemoteUser:57]securityLevel:4>=5)
	$stringUniqueID:=WCapi_GetParameter("userName"; "")
	$tablename:=WCapi_GetParameter("tableName"; "")
	$title:=WCapi_GetParameter("title"; "")
	$uniqueID:=Num:C11(WCapi_GetParameter("id"; ""))
	Case of 
		: ($tableName="SyncRelation")
			QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8=$title)
			If (Records in selection:C76([SyncRelation:103])>0)
				vResponse:="Record Found"
				DB_ShowCurrentSelection(->[SyncRelation:103]; ""; 0; "RemoteOpen: "+$userName; 0)
			Else 
				vResponse:="Failed: No SyncRelation Record"
			End if 
		: ($tableName="SyncExchange")
			QUERY:C277([ETLJob:104]; [ETLJob:104]idNum:1=$uniqueID)
			If (Records in selection:C76([ETLJob:104])>0)
				vResponse:="Record Found"
				DB_ShowCurrentSelection(->[ETLJob:104]; ""; 0; "RemoteOpen: "+$userName; 0)
			Else 
				vResponse:="Failed: No SyncRelation Record"
			End if 
		: ($tableName="SyncRecord")
			QUERY:C277([SyncRecord:109]; [SyncRecord:109]idNum:1=$uniqueID)
			If (Records in selection:C76([SyncRecord:109])>0)
				vResponse:="Record Found"
				DB_ShowCurrentSelection(->[SyncRecord:109]; ""; 0; "RemoteOpen: "+$userName; 0)
			Else 
				vResponse:="Failed: No SyncRelation Record"
			End if 
	End case 
End if 