//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/27/19, 10:40:05
// ----------------------------------------------------
// Method: RP_SOtoPOtoVendorSO
// Description
// 
//
// Parameters
// ----------------------------------------------------



//  aOrdLnSel  is the array of selected lines to create a PO from the SO
// Two options to work on 
If (False:C215)
	// this is better but more complex used for a long time
	// need to test it with record passing 
	vHere:=1  // aOrdLnSel is managed by this
	
	// ### bj ### 20190209_0006
	// on hold until I make a SyncRelation switching mechanism
	
	Ord2POByVendor  // this breaks an order down into a PO per vendor
	C_LONGINT:C283($inc; $cnt)
	C_TEXT:C284($comment)
	$cnt:=Records in selection:C76([PO:39])
	If ($cnt>0)
		// ARRAY TEXT($aVendorID;0)
		// DISTINCT VALUES([PO]VendorID;$aVendorID)
		FIRST RECORD:C50([PO:39])
		For ($inc; 1; $cnt)
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
			QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="POstoVendor-"+[Vendor:38]vendorID:1)
			If (Records in selection:C76([SyncRelation:103])=1)
				REDUCE SELECTION:C351([SyncRecord:109]; 0)
				// the [SyncRecord] will be created during the sending process
				RP_JSONSend
				$comment:="RecordPassing: "+[SyncRelation:103]name:8
			Else 
				$comment:="RecordPassing Error: [SyncRelation]Name defined"
			End if 
			// zzzqqq jDateTimeStamp(->[PO:39]commentProcess:63; $comment)
			SAVE RECORD:C53([PO:39])
			NEXT RECORD:C51([PO:39])
		End for 
	End if 
Else 
	// demo version for working test
	// ### bj ### 20190125_2147
	C_TEXT:C284(vtRPVendorID)
	// must be set in the calling script
	If (vtRPVendorID="")
		If ([SyncRelation:103]partnerNumber:14=1)
			vtRPVendorID:=[SyncRelation:103]partner2Accountid:47
		Else 
			vtRPVendorID:=[SyncRelation:103]partner1Accountid:36
		End if 
	End if 
	
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=vtRPVendorID)
	// ### bj ### 20190127_1042
	// [SyncRelation] can now be used for all types of transactions between parnters 
	// one record per partnership instead of one per transaction type
	
	// depends on the path to this
	If (vtRPUUIDKey#[SyncRelation:103]id:30)
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]id:30=vtRPUUIDKey)
	End if 
	
	If (([Vendor:38]vendorID:1#"") & ([SyncRelation:103]name:8#""))
		Ord2POForceVendor  // create the PO from the SO
		//  RP_PO2VendorSO ($ptObject)  // move this outside this procedure
	Else 
		ConsoleLog("Failed: Ord2POForceVendor <>vtVendorIDRP: "+[Vendor:38]vendorID:1+" : [SyncRelation]Name: "+[SyncRelation:103]name:8)
	End if 
	vtVendorIDRP:=""
End if 


