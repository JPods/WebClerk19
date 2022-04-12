//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/18/21, 00:19:13
// ----------------------------------------------------
// Method: Init_User
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($obRec; $obSel)
C_OBJECT:C1216($obRecPrime; $obSelPrime)
C_TEXT:C284($vtID; $tableName)
// pass a parameter to just fill out voUser)
vResponse:="Error: No action"
If (Count parameters:C259=1)
	vResponse:="Object"
Else 
	$vtID:=WCapi_GetParameter("idUser")
	$obSel:=ds:C1482.EventLog.query("id = :1"; $vtID)
	If ($obSel.first()=Null:C1517)
		vResponse:="Error: You must be signed in to obtain the userObject"
	Else 
		//$tableName:=
		// $obSelPrime:=ds.RemoteUser.query("id = :1"; [EventLog]idRemoteUser)
		// change this
		If ([EventLog:75]wccRemoteUserRec:26#0)
			GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]wccRemoteUserRec:26)
		Else 
			GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]remoteUserRec:10)
		End if 
	End if 
End if 
If (vResponse#"Error@")
	
	
	If (vResponse="Object")
		vResponse:=JSON Stringify:C1217(voUser)
	End if 
	Case of 
		: (True:C214)
			// look at adding a different name choice
		: ([RemoteUser:57]tableNum:9=19)
			
			
	End case 
End if 