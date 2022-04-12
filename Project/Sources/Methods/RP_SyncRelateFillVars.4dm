//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/28/21, 21:50:33
// ----------------------------------------------------
// Method: RP_SyncRelateFillVars
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_OBJECT:C1216($voSel; $voRec)
C_OBJECT:C1216($0)
C_TEXT:C284($1; $vtName)
If (Count parameters:C259=0)
	$vtName:="maps.googleapis.com"  // $1  //  Google Maps: 
Else 
	$vtName:=$1  //  Google Maps: "maps.googleapis.com"
End if 

$voSel:=ds:C1482.SyncRelation.query("name = :1"; $vtName)
$voRec:=$voSel.first()
vUsername:=$voRec.remoteUserName
vPassword:=$voRec.remoteUserPassword
HTTP_Protocol:=$voRec.protocol
HTTP_Port:=$voRec.portProduction
If ($voRec.partnerNumber=2)
	HTTP_Host:=$voRec.partner1URL
Else 
	HTTP_Host:=$voRec.partner2URL
End if 

If ($voRec.command="/RP_json@")
	HTTP_Path:="/RP_json"+$voRec.id
Else 
	HTTP_Path:=$voRec.command
End if 

HTTP_TimeOut:=$voRec.timeOut
HTTP_APIKey:=$voRec.pin
vScript:=$voRec.scriptBefore

HTTP_ContentType:=""

// when called outside Record Passing, this should already be the same
// depending on which was used to retrieve the record
vUniqueID:=$voRec.idNum
vtRPUUIDKey:=$voRec.id
$0:=$voRec