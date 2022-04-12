//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/18/19, 16:08:34
// ----------------------------------------------------
// Method: RP_Shipments
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptObect)
C_OBJECT:C1216($obComplete)
If (Count parameters:C259=0)
	OB SET:C1220($obComplete; "Error"; "NoObjectPointer")
	$ptObect->:=$obComplete
Else 
	$ptObect:=$1
	
	If (False:C215)  // jump past to test
		READ ONLY:C145([Invoice:26])
		READ ONLY:C145([LoadTag:88])
		READ ONLY:C145([LoadItem:87])
		READ ONLY:C145([SyncRelation:103])
		C_LONGINT:C283($ordNum)
		QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=2969)
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="SOtoSO")
		// 
	End if 
	ARRAY OBJECT:C1221($aObBuild; 0)
	C_LONGINT:C283($incRec; $cntRec)
	$cntRec:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	For ($incRec; 1; $cntRec)
		
		INSERT IN ARRAY:C227($aObBuild; $incRec; 1)
		
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerid:1)
		QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
		QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
		
		ExecuteText(0; [SyncRelation:103]scriptData:28)
		
		jsonRecordToObject(->$aObBuild{$incRec}; "Order")
		
		jsonSelectionToObject(->$aObBuild{$incRec}; "OrderLine")
		
		jsonSelectionToObject(->$aObBuild{$incRec}; "Customer")
		
		jsonSelectionToObject(->$aObBuild{$incRec}; "Contact")
		
		jsonSelectionToObject(->$aObBuild{$incRec}; "Payment")
		
		NEXT RECORD:C51([Order:3])
	End for 
	
	C_OBJECT:C1216($obComplete)
	OB SET ARRAY:C1227($obComplete; "body"; $aObBuild)
	
	C_LONGINT:C283($dataSize)
	$dataSize:=Length:C16(JSON Stringify:C1217($obComplete))
	
	// this is now the body
	// create the header
	
	
	C_OBJECT:C1216($obHeader)
	jsonCreateHeader(->$obHeader; "SOtoSOs"; "Local:SO,Remote:SO")
	OB SET:C1220($obComplete; "head"; $obHeader)
	
	C_OBJECT:C1216($objSyncRecord)
	RP_SyncRecordSending($dataSize)  // ;$script)  //just builds the Sync Record
	// syncObject is a variable created
	
	jsonRecordToObject(->$obComplete; "SyncRecord")  //  send all the fields, sort out later if this is too much
	
	
	vWCPayload:=JSON Stringify:C1217($obComplete)
	[SyncRecord:109]body:34:=vWCPayload
	SAVE RECORD:C53([SyncRecord:109])
	
	$ptObect->:=$obComplete
	
End if 

