//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/29/19, 11:12:39
// ----------------------------------------------------
// Method: TextToDocument
// Description
// updated file name to Field Name + Date_Time
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($vtText)
C_POINTER:C301($1; $vpField)
$vpField:=$1
$vtFieldName:=Field name:C257($vpField)

Case of 
	: (Type:C295($vpField->)=Is alpha field:K8:1)
		$vtText:=$vpField->
		
	: (Type:C295($vpField->)=Is text:K8:3)
		$vtText:=$vpField->
		
	: (Type:C295($vpField->)=Is object:K8:27)
		
		$vtText:=JSON Stringify:C1217($vpField->; *)
		
	: (Type:C295($vpField->)=Is BLOB:K8:12)
		// do nothing
	: (Type:C295($vpField->)=Is null:K8:31)
		// do nothing
	: (Type:C295($vpField->)=Is picture:K8:10)
		// do nothing
	: (Type:C295($vpField->)=Is undefined:K8:13)
		// do nothing
		
		// other cases could be added for Dates, Times....
	Else 
		// convert all other cases to text
		$vtText:=String:C10($vpField->)
End case 

If ($vtText#"")
	$vtDateTime:=DateTime("yyyymmdd_hhmmss")
	//$vtDocName:=$vtFieldName+"_"+String(DateTime_DTTo )+"_"+String(Current process)+".txt"
	$vtDocName:=$vtFieldName+"_"+$vtDateTime+".txt"
	$vhDoc:=Create document:C266(Storage:C1525.folder.jitDebug+$vtDocName)
	If (OK=1)
		SEND PACKET:C103($vhDoc; $vtText)
		CLOSE DOCUMENT:C267($vhDoc)
		$vtDocName:=Storage:C1525.folder.jitDebug+$vtDocName
		// Case of 
		OPEN URL:C673($vtDocName)
	End if 
End if 