//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/30/20, 22:46:02
// ----------------------------------------------------
// Method: RP_DataTasks
// Description
// 
//
// Parameters
// ----------------------------------------------------



//  RP_BuildParse   manages the data on the other side

C_POINTER:C301($1; $ptObject)
C_TEXT:C284($2; vtRPCommand; $3; $script)
If (Count parameters:C259=3)
	$ptObject:=$1
	// vtRPCommand:=vtRPCommand
	$script:=$3
Else 
	If (Count parameters:C259#0)  //. testing
		$ptObject:=$1
	End if 
	// vtRPCommand:=vtRPCommand
	$script:=[SyncRelation:103]scriptBefore:7
End if 

C_TEXT:C284(vtRPjson)
C_OBJECT:C1216(obDataSync)
C_OBJECT:C1216($obEmpty)



Case of 
	: (vtRPCommand="executescript")  // setup a number o
		obDataSync:=$obEmpty
		ExecuteText(0; $script)
		//  vtRPjson return from script in format of $vtClusterGroup:=jsonClusterArrays ("ItemsCluster";"Purpose,Sync")
		//  obtRPObject:=JSON Parse(vtRPjson)  // json text to objects
		$ptObject->:=obDataSync
		
	: (vtRPCommand="POstoVendor")  // convert a customers PO into a SO
		
		//   (([SyncRecord]Direction="out") | ([SyncRecord]Direction="sending"))
		// [SyncRecord] is not yet created
		ExecuteText(0; [SyncRelation:103]scriptBefore:7)
		RP_PO2VendorSO($ptObject)
		ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		
	: (vtRPCommand="POsCreateSO")
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))  // received 
			vtRPCommand:="POsCreateSO"
			RP_CreateSOfromPO(->[SyncRecord:109]obReceived:46)
		End if 
		
		
	: (vtRPCommand="SOtoPOtoVendorSO")  // do not use this
		// ### bj ### 20200330_1252
		
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
		Else 
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_SOtoPO  // create the PO from the SO
			RP_PO2VendorSO($ptObject)  // send the PO to the Vendor
			
			If (False:C215)
				// ### bj ### 20190210_1245
				// this converts the received PO into a vendor sales order
				// builds it from the SyncRecord data
				RP_CreateSOfromPO
			End if 
			
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
		
		
	: (vtRPCommand="SORemotetoSOInternal")
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
			
		Else 
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_SO2SO($ptObject; "Out")
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
		
	: (vtRPCommand="ItemsVirtualInventory")  // setup a number of standard canned sends for items
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
			
		Else 
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_ItemsSend($ptObject; "ItemsVirtualInventory")
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
		
	: (vtRPCommand="ItemsFromVendor")  // setup a number of standard canned sends for items
		If (([SyncRecord:109]direction:29="out") | ([SyncRecord:109]direction:29="sending"))
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_ItemsSend($ptObject; "ToVendor")
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
	: (vtRPCommand="ItemstoVendor")  // setup a number of standard canned sends for items
		ExecuteText(0; [SyncRelation:103]scriptBefore:7)
		RP_ItemsSend($ptObject; "ToVendor")
		ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		
	: (vtRPCommand="ItemsFromCustomer")  // setup a number of standard canned sends for items
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
			// ### bj ### 20200330_2308
			// writeThis
		End if 
	: (vtRPCommand="ItemstoCustomer")  // setup a number of standard canned sends for items
		ExecuteText(0; [SyncRelation:103]scriptBefore:7)
		RP_ItemsSend($ptObject; "ToCustomer")
		ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		
		
		
	: (vtRPCommand="ItemstoRep")  // setup a number of standard canned sends for items
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
			
		Else 
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_ItemsSend($ptObject; "ToRep")
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
		
		
		
	: (vtRPCommand="ItemstoAlly")  // setup a number of standard canned sends for items
		
		
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
			
			
		Else 
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_ItemsSend($ptObject; "ToAlly")
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
		
		
	: (vtRPCommand="Project")
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
			
			
		Else 
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_Project($ptObject)
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
		
		
		
		
	: (vtRPCommand="Shipments")  // setup a number of standard canned sends for items
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
			
		Else 
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_Shipments($ptObject)
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
		
	: (vtRPCommand="SpecialDiscounts")  // setup a number of standard canned sends for items
		If (([SyncRecord:109]direction:29="in") | ([SyncRecord:109]direction:29="receiving"))
			
		Else 
			ExecuteText(0; [SyncRelation:103]scriptBefore:7)
			RP_SpecialDiscounts($ptObject)
			ExecuteText(0; [SyncRelation:103]scriptAfter:11)
		End if 
		
	Else 
		
		ARRAY OBJECT:C1221($aObBuild; 0)
		QUERY:C277([Item:4]; [Item:4]itemNum:1="BB40@")
		C_LONGINT:C283($incRec; $cntRec)
		$cntRec:=Records in selection:C76([Item:4])
		FIRST RECORD:C50([Item:4])
		For ($incRec; 1; $cntRec)
			INSERT IN ARRAY:C227($aObBuild; $incRec; 1)
			jsonRecordToObject(->$aObBuild{$incRec}; "Item")
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
			jsonRecordToObject(->$aObBuild{$incRec}; "ItemSpec")
			NEXT RECORD:C51([Item:4])
		End for 
		C_OBJECT:C1216($obBody)
		OB SET ARRAY:C1227($obBody; "body"; $aObBuild)
		
		C_LONGINT:C283($dataSize)
		$dataSize:=Length:C16(JSON Stringify:C1217($obBody))
		
		C_OBJECT:C1216($obComplete)
		C_OBJECT:C1216($obHeader)
		jsonCreateHeader(->$obHeader; "ItemTest"; "Local:BB40,Remote:BB40")
		
		C_OBJECT:C1216($obSync)
		RP_SyncRecordSending($dataSize)  // ;$script)  //just builds the Sync Record
		// syncObject is a variable created
		
		OB SET:C1220($obHeader; "SyncRecord"; $obSync)
		
		vWCPayload:=JSON Stringify:C1217($obComplete)
		// jsonRecordToObject (->$obHeader;"SyncRecord")  //  send all the fields, sort out later if this is too much
		// it gets unloaded in building the json
		LOAD RECORD:C52([SyncRecord:109])
		
		OB SET:C1220($obComplete; "body"; $obBody)
		OB SET:C1220($obComplete; "head"; $obHeader)
		
		// Move to incoming also
		Case of 
			: (<>vbSaveWCPayLoad=1)
				[SyncRecord:109]obReceived:46:=JSON Parse:C1218(vWCPayload)
			: (<>vbSaveWCPayLoad=2)
				[SyncRecord:109]body:34:=vWCPayload
			: (<>vbSaveWCPayLoad=3)
				[SyncRecord:109]body:34:=vWCPayload
				// only if received.
				// [SyncRecord]ObReceived:=JSON Parse([SyncRecord]Body)
			Else 
				// ### bj ### 20190125_2007
				// once we are confident we understand everything, data can be stored externally
		End case 
		
		
		SAVE RECORD:C53([SyncRecord:109])
		
		$ptObject->:=$obComplete
		
End case 



