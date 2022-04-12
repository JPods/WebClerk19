//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/20/19, 00:22:02
// ----------------------------------------------------
// Method: RP_SO2SO
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptObect)
C_TEXT:C284($2; $direction)
$direction:=$2

If ($direction="in")
	$ptObect:=$1
	READ ONLY:C145([SyncRelation:103])
	READ ONLY:C145([SyncRecord:109])
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="SOtoSO")
	QUERY:C277([SyncRecord:109]; [SyncRecord:109]idNum:1=579)
	$obPayload:=[SyncRecord:109]obGeneral:16
	
	C_OBJECT:C1216($obPayload)
	C_OBJECT:C1216($obhead)
	C_OBJECT:C1216($obSyncRecord)
	$obSyncRecord:=OB Get:C1224($obPayload; "SyncRecord")
	$obhead:=OB Get:C1224($obPayload; "head")
	ARRAY OBJECT:C1221($aObBuild; 0)
	OB GET ARRAY:C1229($obPayload; "body"; $aObBuild)
	
	
	
	RP_SycnRecordReceived(->$obSyncRecord)  // save the changed record with the local uniqueID
	
	C_LONGINT:C283($incRay; $cntRay; $fia; $tableNum)
	C_LONGINT:C283($viFieldType)
	$cntRay:=Size of array:C274($aObBuild)
	
	// this is how many orders are in the exchange
	// each array element has:
	// 1. Orders object
	// 2. Customers object
	// 3. array of Contacts
	// 4. array of Payments
	
	C_OBJECT:C1216($obOrders)
	C_OBJECT:C1216($obCustomers)
	ARRAY OBJECT:C1221($aobContacts; 0)
	ARRAY OBJECT:C1221($aobPayments; 0)
	C_OBJECT:C1216($obElement)
	
	For ($incRay; 1; $cntRay)
		ARRAY TEXT:C222($atNames; 0)
		ARRAY LONGINT:C221($aiTypes; 0)
		START TRANSACTION:C239
		vResponse:=""
		$obElement:=$aObBuild{$incRay}
		OB GET PROPERTY NAMES:C1232($obElement; $atNames; $alTypes)
		$obOrders:=OB Get:C1224($obElement; "Order")
		jsonObjectToRecord("Order"; ->$obOrders)
		If (vResponse="")
			$obCustomers:=OB Get:C1224($obElement; "Customer")
			jsonObjectToRecord("Order"; ->$obOrders)
			If (vResponse="")
				// $fia:=Find in array($atNames;"Contact")
				OB GET ARRAY:C1229($obElement; "Contact"; $aobContacts)
				jsonArrayToSelection("Contact"; ->$aobContacts)
				If (vResponse="")
					OB GET ARRAY:C1229($obElement; "Payment"; $aobPayments)
					jsonArrayToSelection("Contact"; ->$aobPayments)
				End if 
			End if 
		End if 
		If (vResponse="")
			// zzzqqq jDateTimeStamp(->[SyncRecord:109]packingNotes:14; Current user:C182+" unpacked")
			[SyncRecord:109]dtComplete:8:=DateTime_Enter
			[SyncRecord:109]statusReceive:19:="Unpacked"
			SAVE RECORD:C53([SyncRecord:109])
			VALIDATE TRANSACTION:C240
		Else 
			// zzzqqq jDateTimeStamp(->[SyncRecord:109]packingNotes:14; Current user:C182+" Failed unpacking "+vResponse)
			[SyncRecord:109]statusReceive:19:="Failed to unpack"
			CANCEL TRANSACTION:C241
		End if 
	End for 
	C_TEXT:C284($tableName)
	$tableNum:=Table:C252(->[SyncRecord:109])
	C_POINTER:C301($ptField)
	
Else 
	C_OBJECT:C1216($obPayload)
	If (Count parameters:C259=0)
		OB SET:C1220($obPayload; "Error"; "NoObjectPointer")
		$ptObect->:=$obPayload
	Else 
		$ptObect:=$1
		
		If (False:C215)  // jump past to test
			READ ONLY:C145([Order:3])
			READ ONLY:C145([OrderLine:49])
			READ ONLY:C145([Payment:28])
			READ ONLY:C145([Customer:2])
			READ ONLY:C145([Contact:13])
			READ ONLY:C145([SyncRelation:103])
			C_LONGINT:C283($ordNum)
			$ordNum:=2969
			QUERY:C277([Order:3]; [Order:3]idNum:2=2969)
			QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="SOtoSO")
			// 
		End if 
		ARRAY OBJECT:C1221($aObBuild; 0)
		C_LONGINT:C283($incRec; $cntRec)
		$cntRec:=Records in selection:C76([Order:3])
		FIRST RECORD:C50([Order:3])
		For ($incRec; 1; $cntRec)
			
			INSERT IN ARRAY:C227($aObBuild; $incRec; 1)
			
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
			QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
			
			ExecuteText(0; [SyncRelation:103]scriptData:28)
			
			// objects
			jsonRecordToObject(->$aObBuild{$incRec}; "Order")
			jsonRecordToObject(->$aObBuild{$incRec}; "Customer")
			
			// arrays
			jsonSelectionToObject(->$aObBuild{$incRec}; "OrderLine")
			jsonSelectionToObject(->$aObBuild{$incRec}; "Contact")
			jsonSelectionToObject(->$aObBuild{$incRec}; "Payment")
			
			NEXT RECORD:C51([Order:3])
		End for 
		
		C_OBJECT:C1216($obPayload)
		OB SET ARRAY:C1227($obPayload; "body"; $aObBuild)
		
		C_LONGINT:C283($dataSize)
		$dataSize:=Length:C16(JSON Stringify:C1217($obPayload))
		
		// this is now the body
		// create the header
		
		
		C_OBJECT:C1216($obHeader)
		jsonCreateHeader(->$obHeader; "SOtoSOs"; "Local:SO,Remote:SO")
		OB SET:C1220($obPayload; "head"; $obHeader)
		
		C_OBJECT:C1216($objSyncRecord)
		RP_SyncRecordSending($dataSize)  // ;$script)  //just builds the Sync Record
		// syncObject is a variable created
		
		jsonRecordToObject(->$obPayload; "SyncRecord")  //  send all the fields, sort out later if this is too much
		
		vWCPayload:=JSON Stringify:C1217($obPayload)
		
		SAVE RECORD:C53([SyncRecord:109])
		
		$ptObect->:=$obPayload
		
	End if 
End if 
