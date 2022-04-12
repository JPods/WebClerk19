//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/27/18, 00:24:31
// ----------------------------------------------------
// Method: jsonEncryptDecrypt
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtTask)
C_POINTER:C301($2; $ptWorkingIn)
C_TEXT:C284($flatten)
vlObjLevel:=0
C_OBJECT:C1216($obToFlatten)
C_TEXT:C284($vtOutput)

$vtTask:=$1
$ptWorkingIn:=$2  // json incoming

$obToFlatten:=JSON Parse:C1218($ptWorkingIn->)

READ ONLY:C145([SyncRelation:103])
QUERY:C277([SyncRelation:103]; [SyncRelation:103]Name:8=$vtRelateKey)  // get the relationship exchange pair

Case of 
	: ([SyncRelation:103]Name:8#$vtRelateKey)
		$0:="Error, No [SyncRelation]Name = "+$vtRelateKey
	: ($vtTask="encrypt")
		C_TEXT:C284($textToEncrypt)
		C_BLOB:C604($blobToEncrypt)
		
		$obToFlatten:=JSON Parse:C1218($vtWorkingIn)
		$textToEncrypt:=JSON Stringify:C1217($obToFlatten)  // convert to object
		$textToEncrypt:=JSON Stringify:C1217($textToEncrypt)  // stringify object
		VARIABLE TO BLOB:C532($textToEncrypt; $blobToEncrypt)  // put data into a blob that can be transmitted 
		ENCRYPT BLOB:C689($blobToEncrypt; [SyncRelation:103]PrivateKey:45)  // encrypt
		
		
		BLOB TO VARIABLE:C533($blobToEncrypt; $vtOutput)  // put data into a blob that can be transmitted 
		$0:=$textToEncrypt
		//  sent via "Post"
		
	: ($vtTask="decrypt")
		
		C_BLOB:C604($blobToDecrypt)
		C_OBJECT:C1216($obDecrypted)
		C_TEXT:C284($jtDecrypted)
		VARIABLE TO BLOB:C532($vtWorkingIn; $blobToDecrypt)  // put data into a blob that can be transmitted 
		DECRYPT BLOB:C690($blobToDecrypt; [SyncRelation:103]PublicKey:46)  // decrypt
		BLOB TO VARIABLE:C533($blobToDecrypt; $vtDecrypted)  // recover the text
		
		C_OBJECT:C1216($objDecrypt)
		$objDecrypt:=JSON Parse:C1218($vtDecrypted)  // de-stringify the json
		$jtDecrypted:=JSON Stringify:C1217($objDecrypt)  // de-stringify the json  // testing
		//$obDecrypted:=JSON Parse($jtDecrypted)  // put json into an object
		
		$0:=$jtDecrypted
	Else 
		$0:="Error, not valid parameters: "+$vtTask+"; "+$vtRelateKey
End case 

// REDUCE SELECTION([SyncRelation];0)  // not here
READ WRITE:C146([SyncRelation:103])


If (False:C215)  // tinker 
	TEXT TO BLOB:C554(vWCPayload; HTTP_Data; UTF8 text without length:K22:17)
	DECRYPT BLOB:C690(HTTP_Data; [SyncRelation:103]PublicKey:46)  // encrypt
	$vtjson:=BLOB to text:C555(HTTP_Data; Mac text without length:K22:10)
	
	TEXT TO BLOB:C554(vWCPayload; HTTP_Data; Mac text without length:K22:10)
	DECRYPT BLOB:C690(HTTP_Data; [SyncRelation:103]PublicKey:46)  // encrypt
	$vtjson:=BLOB to text:C555(HTTP_Data; UTF8 text without length:K22:17)
	
	TEXT TO BLOB:C554(vWCPayload; HTTP_Data; UTF8 text without length:K22:17)
	DECRYPT BLOB:C690(HTTP_Data; [SyncRelation:103]PublicKey:46)  // encrypt
	$vtjson:=BLOB to text:C555(HTTP_Data; UTF8 text without length:K22:17)
	
	VARIABLE TO BLOB:C532(vWCPayload; $blobToDecrypt)  // put data into a blob that can be transmitted 
	DECRYPT BLOB:C690($blobToDecrypt; [SyncRelation:103]PublicKey:46)  // decrypt
	$vtjson:=BLOB to text:C555($blobToDecrypt; UTF8 text without length:K22:17)  // recover the text
	If (Length:C16($vtjson)=0)
		vResponse:=vResponse+"; Data failed to decrypt."
		$myOK:=0
	End if 
End if 