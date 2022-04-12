//%attributes = {"publishedWeb":true}
//%attributes = {"publishedWeb":true,"folder":"Default Project Methods","lang":"en"} comment added and reserved by 4D.

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/20/19, 15:02:46
// ----------------------------------------------------
// Method: RP_PO2VendorSO
// Description
// 
//
// Parameters
// ----------------------------------------------------

// unpacking
//  RP_CreateSOfromPO (->$obComplete)


C_POINTER:C301($1; $ptObect)

If (Count parameters:C259>0)
	$ptObect:=$1
Else 
	// testing
	C_OBJECT:C1216($obTemp)
	$ptObect:=(->$obTemp)
	READ ONLY:C145([PO:39])
	READ ONLY:C145([Vendor:38])
	READ ONLY:C145([POLine:40])
	READ ONLY:C145([SyncRelation:103])
	QUERY:C277([PO:39]; [PO:39]poNum:5>=2200062; *)
	QUERY:C277([PO:39];  & ; [PO:39]poNum:5<=2200066)
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="testRP_32Send")
End if 

ARRAY OBJECT:C1221($aObBuild; 0)
C_LONGINT:C283($incRec; $cntRec)

// ### bj ### 20200330_1247
// run loops outside this
$cntRec:=Records in selection:C76([PO:39])
FIRST RECORD:C50([PO:39])
If ([Vendor:38]vendorid:1#[PO:39]vendorid:1)
	QUERY:C277([Vendor:38]; [Vendor:38]vendorid:1=[PO:39]vendorid:1)
End if 
For ($incRec; 1; $cntRec)
	If ([PO:39]vendorid:1=[Vendor:38]vendorid:1)
		// ### bj ### 20200330_2139 assure that POs do not leak between vendors
		INSERT IN ARRAY:C227($aObBuild; $incRec; 1)
		
		QUERY:C277([POLine:40]; [POLine:40]poNum:1=[PO:39]poNum:5)
		
		jsonRecordToObject(->$aObBuild{$incRec}; "PO")  // parameter 2 must be a tableName
		
		ExecuteText(0; [SyncRelation:103]scriptData:28)
		
		jsonSelectionToObject(->$aObBuild{$incRec}; "POLine")  // case sensitive
		// put this into an array of POs to send
	End if 
	If ($cntRec>1)
		NEXT RECORD:C51([PO:39])
	End if 
End for 

C_OBJECT:C1216($obBody)
OB SET ARRAY:C1227($obBody; "PO"; $aObBuild)  // array of individual Purchase Order and Lines

// add vendor information to the body
jsonRecordToObject(->$obBody; "Vendor")

C_LONGINT:C283($dataSize)
$dataSize:=Length:C16(JSON Stringify:C1217($obBody))

// create the head and SyncRecord in the head
C_OBJECT:C1216($obPurpose)
jsonCreateHeader(->$obPurpose; "POsToVendorsSOs"; "Local:PO,Remote:SO")
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





