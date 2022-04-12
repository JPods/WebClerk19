//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-05T00:00:00, 23:11:31
// ----------------------------------------------------
// Method: ELog_NewRecord
// Description
// Modified: 12/05/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(<>doEventLogInCreditCard)
C_LONGINT:C283(<>lELogLastDT)
C_LONGINT:C283($1; $eventNum)  //event number (i.e. error number)
C_TEXT:C284($2; $theType)  //event type (i.e. error vs other events)
C_TEXT:C284($3; [EventLog:75]message:4; $message)  //Text of event message
C_BOOLEAN:C305($4)
C_LONGINT:C283($SavedID)
// If (<>doEventLogInCreditCard=1)
$eventNum:=0
$SavedID:=-1
If (Count parameters:C259>0)
	$eventNum:=$1
	If (Count parameters:C259>1)
		$theType:=$2
		If (Count parameters:C259>2)
			$message:=$3
			If (Count parameters:C259>3)
				If ($4=True:C214)
					$SavedID:=Record number:C243([EventLog:75])
				Else 
					$SavedID:=-1
				End if 
			Else 
				$SavedID:=-1
			End if 
		End if 
	End if 
	
	READ WRITE:C146([EventLog:75])
	CREATE RECORD:C68([EventLog:75])
	
	[EventLog:75]dtEvent:1:=DateTime_Enter
	If ([EventLog:75]dtEvent:1<=<>lELogLastDT)  //don't create one with the same DTEvent
		[EventLog:75]dtEvent:1:=<>lELogLastDT+1  //this happens after last
	End if 
	
	<>lELogLastDT:=[EventLog:75]dtEvent:1
	[EventLog:75]groupid:3:=$theType
	[EventLog:75]message:4:=$message
	[EventLog:75]tableNum:9:=-1
	[EventLog:75]customerRecNum:8:=-1
	[EventLog:75]remoteUserRec:10:=-1
	SAVE RECORD:C53([EventLog:75])
	$0:=Record number:C243([EventLog:75])
	UNLOAD RECORD:C212([EventLog:75])
	
	If ($SavedID>=0)  // set to -1 above if not saved
		GOTO RECORD:C242([EventLog:75]; $SavedID)
	End if 
End if 