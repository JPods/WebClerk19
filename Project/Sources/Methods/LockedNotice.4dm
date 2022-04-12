//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/09/09, 16:05:06
// ----------------------------------------------------
// Method: LockedNotice
// Description
// 
//
// Parameters
// ----------------------------------------------------
// 
// LOCKED ATTRIBUTES({aTable;}process;4Duser;sessionUser;processName)
// ### jwm ### 20160322_1023 changed Machine to Session, sessionUser is the Current Machine Owner (Computer Name)
C_POINTER:C301($1; $ptCurTable)
C_TEXT:C284($2; $theNotice)
$ptCurTable:=ptCurTable
$theNotice:="Record is Locked."
If (Count parameters:C259>0)
	$ptCurTable:=$1
	If (Count parameters:C259>1)
		$theNotice:=$2
	End if 
End if 
If (Locked:C147($ptCurTable->))
	LOCKED BY:C353($ptCurTable->; $Process; $User; $Session; $Name)
	If (allowAlerts_boo)
		If ($User="")
			//$User:="you"
			//$Session:="your computer"
			$User:=Current user:C182
			$Session:=Current system user:C484
		End if 
		ALERT:C41(Table name:C256($ptCurTable)+" locked by: "+$User+"\r"+"Session: "+$Session+"\r"+"Process: "+$Name+"\r"+$theNotice)
		vResponse:=vResponse+("\r"*(Num:C11(vResponse#"")))+(Table name:C256($ptCurTable))+" locked by: "+$User+"\r"+"Session: "+$Session+"\r"+"Process: "+$Name+"\r"+$theNotice+"\r"
		// ### jwm ### 20160318_1054 set vResponse in either case
	Else 
		vResponse:=vResponse+("\r"*(Num:C11(vResponse#"")))+(Table name:C256($ptCurTable))+" locked by: "+$User+"\r"+"Session: "+$Session+"\r"+"Process: "+$Name+"\r"+$theNotice+"\r"
	End if 
End if 