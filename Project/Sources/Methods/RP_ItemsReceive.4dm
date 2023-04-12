//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/13/20, 23:51:30
// ----------------------------------------------------
// Method: RP_ItemsReceive
// Description
// 
//
// Parameters
// ----------------------------------------------------

// UNLOAD RECORD([SyncRecord])

If (False:C215)
	READ ONLY:C145([SyncRelation:103])
	READ ONLY:C145([SyncRecord:109])
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="SOfromPO")
	QUERY:C277([SyncRecord:109]; [SyncRecord:109]idNum:1=595)
	$obPayload:=[SyncRecord:109]obReceived:46
	
End if 

// ### bj ### 20190123_2026
// fix this
// link in the UniqueID field
If ([SyncRelation:103]id:30#[SyncRecord:109]idSyncRelation:49)
	READ ONLY:C145([SyncRelation:103])  // remove to increase the count
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]id:30=[SyncRecord:109]idSyncRelation:49)
End if 


C_OBJECT:C1216($obPayload)


If (OB Is defined:C1231([SyncRecord:109]obReceived:46))
	$obPayload:=[SyncRecord:109]obReceived:46
Else 
	If ([SyncRecord:109]body:34#"")
		$obPayload:=JSON Parse:C1218([SyncRecord:109]body:34)
	End if 
End if 

C_OBJECT:C1216($obhead)
C_OBJECT:C1216($obSyncRecord)
C_OBJECT:C1216($obbody)
$obSyncRecord:=OB Get:C1224($obPayload; "SyncRecord")
$obhead:=OB Get:C1224($obPayload; "head")
$obbody:=OB Get:C1224($obPayload; "body")

C_TEXT:C284($vtCommand)
$vtCommand:=OB Get:C1224($obhead; "Command")
// consider adding a test that if 
If ($vtCommand#"ItemsFromVendor")
	ALERT:C41("Processing requires a Command in the head of ItemsFromVendor")
Else 
	
	ARRAY OBJECT:C1221($aObBuild; 0)
	OB GET ARRAY:C1229($obbody; "Item"; $aObBuild)  // array of Item records
	
	C_LONGINT:C283($incRay; $cntRay; $fia; $tableNum)
	C_LONGINT:C283($viFieldType)
	$cntRay:=Size of array:C274($aObBuild)
	// this is how many orders are in the exchange
	// each array element has:
	// 1. Pos object
	// 2. ItemSpecs
	// 3. Documents
	
	If (<>viDebugMode>410)
		ConsoleLog("Number of Items = "+String:C10($cntRay))
	End if 
	
	C_BOOLEAN:C305($vbSelfTesting)
	If ([SyncRelation:103]partnerNumber:14=1)
		If ($vbSelfTesting)
			$vtcustomerID:=[SyncRelation:103]partner1Accountid:36
		Else 
			$vtcustomerID:=[SyncRelation:103]partner2Accountid:47
		End if 
	Else 
		If ($vbSelfTesting)
			$vtcustomerID:=[SyncRelation:103]partner2Accountid:47
		Else 
			$vtcustomerID:=[SyncRelation:103]partner1Accountid:36
		End if 
		$vbSelfTesting:=([SyncRelation:103]partner1URL:2=[SyncRelation:103]partner2URL:33)
	End if 
	
	C_OBJECT:C1216($obItemsRecord)
	C_OBJECT:C1216($obItemSpecsRecord)
	ARRAY OBJECT:C1221($aobDocuments; 0)
	C_OBJECT:C1216($obElement)
	
	// create the vendor sales orders to matching POs
	For ($incRay; 1; $cntRay)
		ARRAY TEXT:C222($atNames; 0)
		ARRAY LONGINT:C221($aiTypes; 0)
		START TRANSACTION:C239
		vResponse:=""
		$obElement:=$aObBuild{$incRay}
		OB GET PROPERTY NAMES:C1232($obElement; $atNames; $alTypes)
		$obItemsRecord:=$obElement.Items
		// jsonObjectToRecord ("PO";->$obItemsRecord)
		// get the partner account in the local system
		
		// force to reverse while testing on the sending machine
		C_TEXT:C284($vtcustomerID)
		
		
		
		
		// $fia:=Find in array($atNames;"Contact")
		OB GET ARRAY:C1229($obElement; "Document"; $aobDocuments)
		RP_DocumentsReceiving("Document"; ->$aobDocuments)
		
		booAccept:=True:C214
		vMod:=True:C214
		
		
		If (allowAlerts_boo)
			$OrderNum:=[Order:3]idNum:2
			If (viRecordShow=1)
				C_TEXT:C284($script; $tag)
				$script:="Query([Order];[Order]ordernum="+String:C10($OrderNum)+")"
				$tag:="SyncRecord: "+String:C10([SyncRecord:109]idNum:1)
				
				REDUCE SELECTION:C351([Order:3]; 0)
				REDUCE SELECTION:C351([Customer:2]; 0)
				REDUCE SELECTION:C351([SyncRelation:103]; 0)
				
				ProcessTableOpen(Table:C252(->[Order:3]); $script; $tag)
			End if 
		End if 
		
		
		
		If (vResponse="")
			// zzzqqq jDateTimeStamp(->[SyncRecord:109]packingNotes:14; Current user:C182+" unpacked")
			[SyncRecord:109]dtComplete:8:=DateTime_DTTo
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
End if 