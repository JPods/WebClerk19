//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/29/11, 23:49:29
// ----------------------------------------------------
// Method: SMTP_EmailExport
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $theRecName; $2; $thePurpose)  //;$2)
C_TEXT:C284($vtSearch)
C_PICTURE:C286($vpSearch)
C_LONGINT:C283($doThis; $securityLevel; $3)
C_TEXT:C284($commentText; vText11; $4)  // was vText11 in the TallyMasters
//
$commentText:=""
$doThis:=Count parameters:C259

//$doThis:=0// FOR TEST ONLY
$securityLevel:=1  //
Case of 
	: (Storage:C1525.user.securityLevel>$securityLevel)
		$securityLevel:=Storage:C1525.user.securityLevel
	: (allowAlerts_boo)
		$securityLevel:=Storage:C1525.user.securityLevel
	: (viEndUserSecurityLevel=0)
		$securityLevel:=1
	Else 
		$securityLevel:=viEndUserSecurityLevel
End case 
If ($doThis<1)
	$theRecName:=""
Else 
	If ($doThis<2)
		$theRecName:=$1
		$thePurpose:="Execute_Tally"
	Else 
		If ($doThis<3)
			$theRecName:=$1
			$thePurpose:=$2
		Else 
			If ($doThis<4)
				$theRecName:=$1
				$thePurpose:=$2
				$securityLevel:=$3
			Else 
				$theRecName:=$1
				$thePurpose:=$2
				$securityLevel:=$3
				If ($doThis=4)
					$commentText:=$4
				End if 
			End if 
		End if 
	End if 
End if 



ExportArraySetup($theRecName; $thePurpose; $securityLevel)  //This builds a text file from the existing records
SMTP_EmailBuild(->[RemoteUser:57])
//If (variable1#"")
//vtEmailReceiver:=Variable1
//End if 
vtEmailAttachment:=document
SMTP_SendMsg4D(False:C215)



C_DATE:C307($dateStatus)
If ((vtEmailStatusMessage="sent") | (vtEmailStatusMessage="verified"))
	$dateStatus:=Current date:C33
Else 
	$dateStatus:=!2001-01-01!
End if 

CREATE RECORD:C68([CallReport:34])

[CallReport:34]email:38:=vtEmailReceiver
[CallReport:34]dateCreate:17:=Current date:C33
[CallReport:34]company:42:=[RemoteUser:57]company:16
[CallReport:34]customerID:1:=[RemoteUser:57]customerID:10
[CallReport:34]tableNum:2:=[RemoteUser:57]tableNum:9
[CallReport:34]attention:18:=[RemoteUser:57]userName:2
[CallReport:34]action:15:="EmailOrderDetails"
[CallReport:34]subject:14:="EmailOrderDetails"
//
[CallReport:34]comment:16:=$commentText
[CallReport:34]emailVerified:46:=$dateStatus
If (vtEmailStatusMessage="Sent")
	[CallReport:34]emailStatus:45:="Verified"
Else 
	[CallReport:34]emailStatus:45:=vtEmailStatusMessage
End if 
//
C_BLOB:C604($sentFile)
DOCUMENT TO BLOB:C525(document; $sentFile)
[CallReport:34]messageText:51:=BLOB to text:C555($sentFile; UTF8 text without length:K22:17)
SAVE RECORD:C53([CallReport:34])

//End if 
DELETE DOCUMENT:C159(document)