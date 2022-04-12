//%attributes = {"publishedWeb":true}
//Method: Prc_Status
C_LONGINT:C283($viIncrement; $viTasks)
C_LONGINT:C283($viState; $RemoteIP; vlBeenHere; $beenHere; viEndUserSecurityLevel; $securityLevel; viRemoteIP; $RemoteIP; $err; $theErr; $s; $theS)
$viTasks:=Count tasks:C335
C_TEXT:C284($theReport; $theName; $theDetails)
vText11:=""

C_LONGINT:C283($beenHere; $securityLevel; $RemoteIP; $theErr; $s; $RemoteIP; $RemoteIP; $securityLevel; $theS)
For ($viIncrement; 1; $viTasks)
	$viState:=Process state:C330($viIncrement)
	PROCESS PROPERTIES:C336($viIncrement; $theName; vi6; vi7)
	$theReport:=$theReport+String:C10($viIncrement)+"\t"+$theName+"\t"+String:C10($viState)+"\t"+String:C10(vi6)+"\t"+String:C10(vi7)+"\r"
	$theDetails:=""
	GET PROCESS VARIABLE:C371($viIncrement; vText11; vText11; vlBeenHere; $beenHere; viEndUserSecurityLevel; $securityLevel; viRemoteIP; $RemoteIP; $err; $theErr; $s; $theS)
End for 
SET TEXT TO PASTEBOARD:C523($theReport)
//