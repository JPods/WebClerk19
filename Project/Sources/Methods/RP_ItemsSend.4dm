//%attributes = {"publishedWeb":true,"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/17/19, 02:21:06
// ----------------------------------------------------
// Method: RP_ItemsSend
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptObject)
C_TEXT:C284($2; $towhom)

$ptObject:=$1

vUniqueID:=2
QUERY:C277([Item:4]; [Item:4]description:7="@biscuit@")
QUERY:C277([SyncRelation:103]; [SyncRelation:103]idNum:1=vUniqueID)
RP_LoadVariablesRelationship


C_LONGINT:C283($incOb; $cntOb)
C_OBJECT:C1216($obWorking)
C_OBJECT:C1216($obDocs; $obSpec)
ARRAY OBJECT:C1221($aObWorking; 0)
$obWorking:=New object:C1471
jsonSelectionToObject(->$obWorking; "Item")
OB GET ARRAY:C1229($obWorking; "Item"; $aObWorking)
$cntOb:=Size of array:C274($aObWorking)
For ($incOb; 1; $cntOb)
	If ($aObWorking{$incOb}.SpecID=Null:C1517)
		$aObWorking{$incOb}.SpecID:=New object:C1471
	End if 
	If ($aObWorking{$incOb}.SpecID="")
		QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
	Else 
		QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]specid:62)
	End if 
	jsonRecordToObject(->$aObWorking{$incOb}; "ItemSpec")  // case sensitive
	
	QUERY:C277([Document:100]; [Document:100]itemNum:20=[Item:4]itemNum:1)
	jsonSelectionToObject(->$aObWorking{$incOb}; "Document")  // case sensitive
	
End for 
vWCPayload:=JSON Stringify:C1217($obWorking)  // text to send

If (False:C215)
	ARRAY OBJECT:C1221($aObBuild; 0)
	C_LONGINT:C283($incRec; $cntRec)
	$cntRec:=Records in selection:C76([Item:4])
	FIRST RECORD:C50([Item:4])
	For ($incRec; 1; $cntRec)
		If ([Item:4]specid:62="")
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
		Else 
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]specid:62)
		End if 
		
		INSERT IN ARRAY:C227($aObBuild; $incRec; 1)
		
		jsonRecordToObject(->$aObBuild{$incRec}; "Item"; vtRPCommand)  // parameter 2 must be a tableName
		
		ExecuteText(0; [SyncRelation:103]scriptData:28)
		
		jsonRecordToObject(->$aObBuild{$incRec}; "ItemSpec")  // case sensitive
		
		QUERY:C277([Document:100]; [Document:100]itemNum:20=[Item:4]itemNum:1)
		jsonSelectionToObject(->$aObBuild{$incRec}; "Document")  // case sensitive
		
		
		NEXT RECORD:C51([Item:4])
	End for 
	
	C_OBJECT:C1216($obBody)
	OB SET ARRAY:C1227($obBody; "Item"; $aObBuild)  // array of individual Purchase Order and Lines
	
	
	C_LONGINT:C283($dataSize)
	$dataSize:=Length:C16(JSON Stringify:C1217($obBody))
	
	// create the head and SyncRecord in the head
	C_OBJECT:C1216($obPurpose)
	jsonCreateHeader(->$obPurpose; vtRPCommand; "Local:Item,Remote:Item")
	RP_SyncRecordSending($dataSize)  // ;$script)  //just builds the Sync Record
	
	
	C_OBJECT:C1216($obComplete)  // create the complete object
	jsonRecordToObject(->$obComplete; "SyncRecord")  //  send all the fields, sort out later if this is too much
	
	LOAD RECORD:C52([SyncRecord:109])  // incase next record was called in jsonRecordToObject
	
	OB SET:C1220($obComplete; "head"; $obPurpose)  // add the b
	OB SET:C1220($obComplete; "body"; $obBody)  // add the body
	
	vWCPayload:=JSON Stringify:C1217($obComplete)  // text to send
	[SyncRecord:109]body:34:=vWCPayload
	// only if received.
	// [SyncRecord]ObReceived:=JSON Parse([SyncRecord]Body)
	SAVE RECORD:C53([SyncRecord:109])
	
	$ptObect->:=$obComplete
End if 
