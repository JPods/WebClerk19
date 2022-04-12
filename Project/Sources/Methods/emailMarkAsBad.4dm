//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-06-23T00:00:00, 22:20:37
// ----------------------------------------------------
// Method: emailMarkAsBad
// Description
// Modified: 06/23/17
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TIME:C306($vhDocRef)
C_TEXT:C284($1; $documentPath; $vtext; $recordMessage)
C_LONGINT:C283($incRay; $cntRay)
C_BLOB:C604($vxBlob)

$errorBeginAOL:="[<01>]"
$errorBeginFollowing:="The following addresses had permanent fatal errors"
$badEmailMessage:="BadEmail "+Date_strYyyymmdd(Current date:C33)+": [["
$recordMessage:=""
C_LONGINT:C283($incRay; $cntRay; $incRec; $cntRec)
KeyModifierCurrent
If (OptKey=1)
	$vtext:=Get text from pasteboard:C524
	$vtext:=Replace string:C233($vtext; "\n"; "\r")
Else 
	If (Count parameters:C259=0)
		$documentPath:=""
	Else 
		$documentPath:=$1
	End if 
	$vhDocRef:=Open document:C264($documentPath; Read mode:K24:5)  // open document read only
	If (OK=1)
		CLOSE DOCUMENT:C267($vhDocRef)  // We don't need to keep it open
		DOCUMENT TO BLOB:C525(document; $vxBlob)  // Load the document
		$vtext:=BLOB to text:C555($vxBlob; UTF8 text without length:K22:17)
	End if 
End if 
If ($vtext#"")
	CREATE SET:C116([CallReport:34]; "Current")
	CREATE RECORD:C68([CallReport:34])
	
	TextToArray($vtext; ->aText1; "\r")
	$cntRay:=Size of array:C274(aText1)
	For ($incRay; 1; $cntRay)
		QUERY:C277([Customer:2]; [Customer:2]email:81=aText1{$incRay}; *)
		QUERY:C277([Customer:2];  | ; [Customer:2]email:81=aText1{$incRay})
		$cntRec:=Records in selection:C76([Customer:2])
		If ($cntRec>0)
			FIRST RECORD:C50([Customer:2])
			For ($incRec; 1; $cntRec)
				$recordMessage:=$badEmailMessage+[Customer:2]email:81+"]]"
				[Customer:2]comment:15:=$badEmailMessage+[Customer:2]email:81+"]]"+"\r"+[Customer:2]comment:15
				// CR_CreateAlways (Table(->[Customer]);[Customer]customerID;"Bad Email";$recordMessage;[Customer]Email;"")
				// ADD TO SET([CallReport];"Current")
				[Customer:2]email:81:=""
				
				[Customer:2]action:60:="Bad email"
				[Customer:2]actionDate:61:=!2017-06-01!
				
				SAVE RECORD:C53([Customer:2])
				NEXT RECORD:C51([Customer:2])
			End for 
			REDUCE SELECTION:C351([Customer:2]; 0)
			REDUCE SELECTION:C351([CallReport:34]; 0)
		End if 
	End for 
	
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
End if 

If (False:C215)
	C_LONGINT:C283($incRec; $cntRec)
	CREATE SET:C116([Customer:2]; "Current")
	CREATE RECORD:C68([Customer:2])
	FIRST RECORD:C50([Customer:2])
	$cntRec:=Records in selection:C76([Customer:2])
	For ($incRec; 1; $cntRec)
		QUERY:C277([Order:3]; [Order:3]customerID:1=[Customer:2]customerID:1)
		If (Records in selection:C76([Order:3])=0)
			ADD TO SET:C119([Customer:2]; "Current")
		End if 
		FIRST RECORD:C50([Customer:2])
	End for 
	REDUCE SELECTION:C351([Order:3]; 0)
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	ALERT:C41(String:C10(Records in selection:C76([Customer:2])))
End if 