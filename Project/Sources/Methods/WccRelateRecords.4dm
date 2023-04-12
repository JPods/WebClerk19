//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccRelateRecords
	//Date: 07/01/02
	//Who: Bill
	//Description: Query related records for web display
End if 
$relatedTables:=WCapi_GetParameter("RelatedTables"; "")
TextToArray($relatedTables; ->aTmpText1; "_")
//TRACE
C_POINTER:C301($1)
C_POINTER:C301($2)
C_BOOLEAN:C305($doAll; $skipAll)
If ((Size of array:C274(aTmpText1)=0) & (Records in selection:C76($1->)=1))
	$doAll:=True:C214
Else 
	$doAll:=(Find in array:C230(aTmpText1; "RelateAll")>0)
End if 
//
$skipAll:=False:C215  //add this sometime
Case of 
	: ($skipAll)
	: ($1=(->[Call:34]))
		Case of 
			: ([Call:34]tableNum:2=2)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Call:34]customerID:1)
			: ([Call:34]tableNum:2=13)  //customer file number
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([Call:34]customerID:1))
				If (Records in selection:C76([Contact:13])=1)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
				End if 
		End case 
		If (Records in selection:C76([Call:34])>1)
			ORDER BY:C49([Call:34]; [Call:34]dtAction:4; <)
		End if 
	: ($1=(->[Customer:2]))
		If (([RemoteUser:57]customerID:10=[Customer:2]customerID:1) | (vWccSecurity>1))
			If ((Find in array:C230(aTmpText1; "dCash")>0) | ($doAll))
				QUERY:C277([DCash:62]; [DCash:62]customerIDApply:1=[Customer:2]customerID:1)
			End if 
			If ((Find in array:C230(aTmpText1; "CallReport")>0) | ($doAll))
				QUERY:C277([Call:34]; [Call:34]tableNum:2=2; *)  //customer file number
				QUERY:C277([Call:34];  & [Call:34]customerID:1=[Customer:2]customerID:1)
				ORDER BY:C49([Call:34]; [Call:34]dtAction:4; <)
			End if 
			If ((Find in array:C230(aTmpText1; "ItemSerial")>0) | ($doAll))
				QUERY:C277([ItemSerial:47]; [ItemSerial:47]customerID:9=[Customer:2]customerID:1)
			End if 
			If ((Find in array:C230(aTmpText1; "Contact")>0) | ($doAll))
				QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
			End if 
			If ((Find in array:C230(aTmpText1; "Order")>0) | ($doAll))
				QUERY:C277([Order:3]; [Order:3]customerID:1=[Customer:2]customerID:1; *)
				QUERY:C277([Order:3];  & [Order:3]complete:83<2)
			End if 
			If ((Find in array:C230(aTmpText1; "Invoice")>0) | ($doAll))
				QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1)
			End if 
			If ((Find in array:C230(aTmpText1; "Service")>0) | ($doAll))
				QUERY:C277([Service:6]; [Service:6]customerID:1=[Customer:2]customerID:1; *)
				QUERY:C277([Service:6];  & [Service:6]dtComplete:18=0)
				ORDER BY:C49([Service:6]; [Service:6]dtDocument:16; <)  //newest entry first
			End if 
			If ((Find in array:C230(aTmpText1; "Payment")>0) | ($doAll))
				QUERY:C277([Payment:28]; [Payment:28]customerID:4=[Customer:2]customerID:1)
			End if 
			If ((Find in array:C230(aTmpText1; "Ledger")>0) | ($doAll))
				QUERY:C277([Ledger:30]; [Ledger:30]customerID:1=[Customer:2]customerID:1)
			End if 
			If ((Find in array:C230(aTmpText1; "QACust")>0) | ($doAll))
				QUERY:C277([QA:70]; [QA:70]customerID:1=[Customer:2]customerID:1)
			End if 
			QUERY:C277([zzzCommunicationDevice:63]; [zzzCommunicationDevice:63]tableNum:2=Table:C252(->[Customer:2]); *)
			QUERY:C277([zzzCommunicationDevice:63];  & [zzzCommunicationDevice:63]customerID:1=[Customer:2]customerID:1)
			//QUERY([ReferencesTable];[ReferencesTable]customerID=[Customer]customerID)
			//QUERY([Payment];[Payment]customerID=[Customer]customerID)
			//ORDER BY([Payment];[Payment]DateReceived;<)
			QUERY:C277([Document:100]; [Document:100]customerID:7=[Customer:2]customerID:1; *)
			QUERY:C277([Document:100];  & [Document:100]tableNum:6=2)
			QUERY:C277([QA:70]; [QA:70]tableNum:11=2; *)
			QUERY:C277([QA:70];  & [QA:70]customerID:1=[Customer:2]customerID:1)
		End if 
	: ($1=(->[Order:3]))
		QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
		If (([RemoteUser:57]customerID:10=[Order:3]customerID:1) | (vWccSecurity>1))
			QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
			pPayAmount:=Sum:C1([Payment:28]amount:1)
			pBalance:=[Order:3]total:27-pPayAmount
			QUERY:C277([PO:39]; [PO:39]idNumOrder:18=[Order:3]idNum:2)
			//QUERY([POLine];[POLine]RefOrderNum=[Order]OrderNum)
			//QUERY([Payment];[Payment]OrderNum=[Order]OrderNum)
			//QUERY([OrdLine];[OrdLine]OrderNum=[Order]OrderNum)
			//
			If ((Find in array:C230(aTmpText1; "Invoice")>0) | ($doAll))
				QUERY:C277([Invoice:26]; [Invoice:26]idNumOrder:1=[Order:3]idNum:2)
			End if 
			If ((Find in array:C230(aTmpText1; "Service")>0) | ($doAll))
				QUERY:C277([Service:6]; [Service:6]idNumOrder:22=[Order:3]idNum:2)
			End if 
			If ((Find in array:C230(aTmpText1; "PO")>0) | ($doAll))
				QUERY:C277([PO:39]; [PO:39]idNumOrder:18=[Order:3]idNum:2)
			End if 
			If ((Find in array:C230(aTmpText1; "POLine")>0) | ($doAll))
				QUERY:C277([POLine:40]; [POLine:40]idNumOrder:16=[Order:3]idNum:2)
			End if 
			If ((Find in array:C230(aTmpText1; "Payment")>0) | ($doAll))
				QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
			End if 
			If ((Find in array:C230(aTmpText1; "Times")>0) | ($doAll))
				QUERY:C277([Time:56]; [Time:56]idNumOrder:3=[Order:3]idNum:2)
			End if 
			If ((Find in array:C230(aTmpText1; "WOdraws")>0) | ($doAll))
				QUERY:C277([WODraw:68]; [WODraw:68]idNumOrder:1=[Order:3]idNum:2)
			End if 
			If ((Find in array:C230(aTmpText1; "WorkOrder")>0) | ($doAll))
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=[Order:3]idNumTask:85)
			End if 
			If ((Find in array:C230(aTmpText1; "Contact")>0) | ($doAll))
				QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
			End if 
		End if 
		QUERY:C277([LoadTag:88]; [LoadTag:88]idNumOrder:29=[Order:3]idNum:2)
		QUERY:C277([LoadItem:87]; [LoadItem:87]idNumOrder:2=[Order:3]idNum:2)
	: ($1=(->[WorkOrder:66]))
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
		If ([WorkOrder:66]idNumTask:22>5)
			QUERY:C277([Order:3]; [Order:3]idNum:2=[WorkOrder:66]idNumTask:22)
			QUERY:C277([Service:6]; [Service:6]idNumOrder:22=[Order:3]idNum:2; *)
			QUERY:C277([Service:6];  & [Service:6]publish:19>0; *)
			QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel)
			QUERY:C277([QA:70]; [QA:70]tableNum:11=(Table:C252(->[Order:3])); *)
			QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([Order:3]idNum:2); *)
			If ([Order:3]idNumTask:85#0)
				QUERY:C277([QA:70];  | [QA:70]idNumTask:12=[Order:3]idNumTask:85; *)
			End if 
			QUERY:C277([QA:70])
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
			QUERY:C277([POLine:40]; [POLine:40]idNumOrder:16=[Order:3]idNum:2)
			QUERY:C277([Document:100]; [Document:100]event:9=String:C10([Order:3]idNumTask:85))
		End if 
		P_OrdHeadVars
	: ($1=(->[Invoice:26]))
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
		If (([RemoteUser:57]customerID:10=[Invoice:26]customerID:3) | (vWccSecurity>1))
			If ([Invoice:26]idNumOrder:1>9)
				QUERY:C277([Service:6]; [Service:6]idNumInvoice:23=[Invoice:26]idNum:2; *)
				QUERY:C277([Service:6];  | [Service:6]idNumOrder:22=[Invoice:26]idNumOrder:1)
			Else 
				QUERY:C277([Service:6]; [Service:6]idNumInvoice:23=[Invoice:26]idNum:2)
			End if 
		End if 
		QUERY:C277([Payment:28]; [Payment:28]idNumInvoice:3=[Invoice:26]idNum:2)
		pPayAmount:=Sum:C1([Payment:28]amount:1)
		pBalance:=[Order:3]total:27-pPayAmount
		QUERY:C277([LoadTag:88]; [LoadTag:88]idNumInvoice:19=[Invoice:26]idNum:2)
		QUERY:C277([LoadItem:87]; [LoadItem:87]invoiceNum:14=[Invoice:26]idNum:2)
	: ($1=(->[Employee:19]))
		If (([RemoteUser:57]customerID:10=[Employee:19]nameID:1) | (vWccSecurity>1))
			If ((Find in array:C230(aTmpText1; "Contact")>0) | ($doAll))
				QUERY:C277([Territory:25]; [Territory:25]purpose:6=0; *)
				QUERY:C277([Territory:25];  & [Territory:25]salesNameID:1=[Employee:19]nameID:1)
			End if 
		End if 
	: ($1=(->[Item:4]))
		If ((viEndUserSecurityLevel>=[Item:4]publish:60) & ([Item:4]publish:60>0))
			If ((Find in array:C230(aTmpText1; "ItemSpec")>0) | ($doAll))
				If ([Item:4]specid:62="")
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
				Else 
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]specid:62)
				End if 
			End if 
			If ((Find in array:C230(aTmpText1; "Usage")>0) | ($doAll))
				If ([Item:4]tallyByType:19)
					QUERY:C277([Usage:5]; [Usage:5]itemNum:1=[Item:4]type:26)
				Else 
					QUERY:C277([Usage:5]; [Usage:5]itemNum:1=[Item:4]itemNum:1)
				End if 
			End if 
			If ((Find in array:C230(aTmpText1; "ItemXRef")>0) | ($doAll))
				QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNum:1=[Item:4]itemNum:1)
			End if 
			If ((Find in array:C230(aTmpText1; "dInventory")>0) | ($doAll))
				QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Item:4]itemNum:1)
			End if 
			If ((Find in array:C230(aTmpText1; "ItemSerial")>0) | ($doAll))
				QUERY:C277([ItemSerial:47]; [ItemSerial:47]itemNum:1=[Item:4]itemNum:1)
			End if 
		End if 
	: ($1=(->[Usage:5]))
		C_LONGINT:C283($beginSR; $endSR)
		C_DATE:C307($endDate)
		If (vWccSecurity>10)
			If ((Find in array:C230(aTmpText1; "dInventory")>0) | ($doAll))
				$endDate:=Date_ThisMon([Usage:5]periodDate:2; 1)
				$beginSR:=DateTime_DTTo([Usage:5]periodDate:2; ?00:00:00?)
				$endSR:=DateTime_DTTo($endDate; ?00:00:00?)
				QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Usage:5]itemNum:1; *)
				QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=$beginSR; *)
				QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<$endSR)
			End if 
		End if 
	: ($1=(->[UsageSummary:33]))
		If (vWccSecurity>10)
			If ((Find in array:C230(aTmpText1; "Usage")>0) | ($doAll))
				RELATE MANY:C262([UsageSummary:33]periodDate:2)
			End if 
		End if 
	: ($1=(->[Rep:8]))
		If ((vWccSecurity>=1000) & ([Rep:8]repIDGroup:45#""))
			$repID:=[Rep:8]repIDGroup:45+"@"
		Else 
			$repID:=[Rep:8]repID:1
		End if 
		If ((Find in array:C230(aTmpText1; "Service")>0) | ($doAll))
			QUERY:C277([Service:6]; [Service:6]repID:2=$repID)
		End if 
		If ((Find in array:C230(aTmpText1; "RepContacts")>0) | ($doAll))
			QUERY:C277([RepContact:10]; [RepContact:10]repID:1=$repID)
		End if 
		If ((Find in array:C230(aTmpText1; "Order")>0) | ($doAll))
			QUERY:C277([Order:3]; [Order:3]repID:8=$repID)
		End if 
		If ((Find in array:C230(aTmpText1; "Invoice")>0) | ($doAll))
			QUERY:C277([Invoice:26]; [Invoice:26]repID:22=$repID)
		End if 
		If ((Find in array:C230(aTmpText1; "Proposal")>0) | ($doAll))
			QUERY:C277([Proposal:42]; [Proposal:42]repID:7=$repID)
		End if 
		If ((Find in array:C230(aTmpText1; "Territories")>0) | ($doAll))
			QUERY:C277([Territory:25]; [Territory:25]purpose:6=0; *)
			QUERY:C277([Territory:25];  & [Territory:25]repID:2=$repID)
		End if 
		If ((Find in array:C230(aTmpText1; "Quota")>0) | ($doAll))
			QUERY:C277([Quota:9]; [Quota:9]repID:1=$repID)
			ORDER BY:C49([Quota:9]; [Quota:9]period:3)
			LAST RECORD:C200([Quota:9])
			vPeriod:=[Quota:9]period:3
		End if 
	: ($1=(->[Service:6]))
		If (([RemoteUser:57]customerID:10=[Service:6]customerID:1) | (vWccSecurity>1))
			Srch_RelatedNotNull(->[Customer:2]; ->[Customer:2]customerID:1; ->[Service:6]customerID:1)
			Srch_RelatedNotNull(->[Order:3]; ->[Service:6]idNumOrder:22; ->[Service:6]idNumOrder:22)
			Srch_RelatedNotNull(->[Invoice:26]; ->[Invoice:26]idNum:2; ->[Service:6]idNumInvoice:23)
			Srch_RelatedNotNull(->[Proposal:42]; ->[Proposal:42]idNum:5; ->[Service:6]idNumProposal:27)
		End if 
	: ($1=(->[Contact:13]))
		If ((Find in array:C230(aTmpText1; "Quota")>0) | ($doAll))
			QUERY:C277([Call:34]; [Call:34]tableNum:2=13; *)  //customer file number
			QUERY:C277([Call:34];  & [Call:34]customerID:1=String:C10([Contact:13]idNum:28))
			ORDER BY:C49([Call:34]; [Call:34]dtAction:4; <)
		End if 
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
	: ($1=(->[Proposal:42]))
		If (([RemoteUser:57]customerID:10=[Proposal:42]customerID:1) | (vWccSecurity>1))
			QUERY:C277([Service:6]; [Service:6]idNumProposal:27=[Proposal:42]idNum:5)
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
		End if 
	: ($1=(->[ProposalLine:43]))
		If (([RemoteUser:57]customerID:10=[ProposalLine:43]customerID:42) | (vWccSecurity>1))
			QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=[ProposalLine:43]idNumProposal:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
		End if 
	: ($1=(->[PO:39]))
		If (([RemoteUser:57]customerID:10=[POLine:40]vendorID:24) | (vWccSecurity>1))
			QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
		End if 
	: ($1=(->[POLine:40]))
		If (([RemoteUser:57]customerID:10=[PO:39]vendorID:1) | (vWccSecurity>1))
			QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
		End if 
	: ($1=(->[Vendor:38]))
		
		
		
	: ($1=(->[Usage:5]))
		$EndDate:=Date_ThisMon([Usage:5]periodDate:2; 1)
		QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Usage:5]itemNum:1; *)
		QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=DateTime_DTTo([Usage:5]periodDate:2; ?00:00:00?); *)
		QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=DateTime_DTTo($EndDate; ?23:59:59?))
		
	: ($1=(->[Payment:28]))
		If (([RemoteUser:57]customerID:10=[Payment:28]customerID:4) | (vWccSecurity>1))
			QUERY:C277([DCash:62]; [DCash:62]docApply:3=[Payment:28]idNum:8; *)
			QUERY:C277([DCash:62];  & [DCash:62]tableApply:2="P"+"@")
		End if 
	: ($1=(->[ItemSerial:47]))
		QUERY:C277([ItemSerialAction:64]; [ItemSerialAction:64]itemSerialid:1=[ItemSerial:47]idNum:18)
	: ($1=(->[QAQuestion:71]))
		QUERY:C277([QAAnswer:72]; [QAAnswer:72]idNumQAQuestion:1=[QAQuestion:71]idNum:1)
End case 
ARRAY TEXT:C222(aTmpText1; 0)
