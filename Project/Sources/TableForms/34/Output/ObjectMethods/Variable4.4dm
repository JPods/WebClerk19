If (False:C215)
	TCStrong_prf_v142_ProcExt
	//01/31/03.prf
	//replaced Proc.Ext commands with native commands or removed if not available
End if 
If (vHere=1)
	TRACE:C157
	CREATE SET:C116([CallReport:34]; "Open")
	CREATE EMPTY SET:C140([Customer:2]; "CustLables")
	CREATE EMPTY SET:C140([Vendor:38]; "VendLables")
	CREATE EMPTY SET:C140([Contact:13]; "ContLables")
	CREATE EMPTY SET:C140([Rep:8]; "RepLables")
	FIRST RECORD:C50([CallReport:34])
	For ($i; 1; Records in selection:C76([CallReport:34]))
		Case of 
				
			: (([CallReport:34]tableNum:2=Table:C252(->[Customer:2])) | ([CallReport:34]tableNum:2=Table:C252(->[Order:3])) | ([CallReport:34]tableNum:2=Table:C252(->[Service:6])) | ([CallReport:34]tableNum:2=Table:C252(->[Invoice:26])) | ([CallReport:34]tableNum:2=Table:C252(->[Payment:28])) | ([CallReport:34]tableNum:2=Table:C252(->[Proposal:42])))
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[CallReport:34]customerID:1)
				If (Records in selection:C76([Customer:2])=1)
					ADD TO SET:C119([Customer:2]; "CustLables")
				End if 
			: ([CallReport:34]tableNum:2=Table:C252(->[Contact:13]))
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([CallReport:34]customerID:1))
				If (Records in selection:C76([Contact:13])=1)
					ADD TO SET:C119([Contact:13]; "ContLables")
				End if 
			: (([CallReport:34]tableNum:2=Table:C252(->[Vendor:38])) | ([CallReport:34]tableNum:2=Table:C252(->[PO:39])))
				QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[CallReport:34]customerID:1)
				If (Records in selection:C76([Vendor:38])=1)
					ADD TO SET:C119([Vendor:38]; "VendLables")
				End if 
			: ([CallReport:34]tableNum:2=Table:C252(->[Rep:8]))
				QUERY:C277([Rep:8]; [Rep:8]repID:1=[CallReport:34]customerID:1)
				If (Records in selection:C76([Rep:8])=1)
					ADD TO SET:C119([Rep:8]; "RepLables")
				End if 
		End case 
		NEXT RECORD:C51([CallReport:34])
	End for 
	//
	If (Records in set:C195("LeadLables")>0)
		ALERT:C41("Print ShowLead Labels")
		USE SET:C118("LeadLables")
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	End if 
	CLEAR SET:C117("LeadLables")
	//
	If (Records in set:C195("CustLables")>0)
		ALERT:C41("Print Customer Labels")
		USE SET:C118("CustLables")
		<>ptPrintTable:=(->[Customer:2])
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		//If (False)//Is macOS)
		//SuperLabel(Table(->[Customer]);"";1536;1;1;"")
		//Else 
		PRINT LABEL:C39([Customer:2]; "xyzzxcv")
		//End if 
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	End if 
	CLEAR SET:C117("CustLables")
	//
	If (Records in set:C195("ContLables")>0)
		ALERT:C41("Print Contact Labels")
		USE SET:C118("ContLables")
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		<>ptPrintTable:=(->[Contact:13])
		// If (Is macOS)
		//  SuperLabel (Table(->[Contact]);"";1536;1;1;"")
		//Else 
		PRINT LABEL:C39([Contact:13]; "xyzzxcv")
		// End if 
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	End if 
	CLEAR SET:C117("ContLables")
	//
	If (Records in set:C195("RepLables")>0)
		ALERT:C41("Print Rep Labels")
		USE SET:C118("RepLables")
		<>ptPrintTable:=(->[Rep:8])
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		// If (Is macOS)
		// SuperLabel (Table(->[Rep]);"";1536;1;1;"")
		// Else 
		PRINT LABEL:C39([Rep:8]; "xyzzxcv")
		//End if 
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	End if 
	CLEAR SET:C117("RepLables")
	//
	If (Records in set:C195("VendLables")>0)
		ALERT:C41("Print Vendor Labels")
		USE SET:C118("VendLables")
		<>ptPrintTable:=(->[Vendor:38])
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		//  If (Is macOS)
		//   SuperLabel (Table(->[Vendor]);"";1536;1;1;"")
		// Else 
		PRINT LABEL:C39([Vendor:38]; "xyzzxcv")
		//End if 
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	End if 
	CLEAR SET:C117("VendLables")
	USE SET:C118("Open")
	CLEAR SET:C117("Open")
End if 