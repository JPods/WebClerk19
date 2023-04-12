//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-24T00:00:00, 16:51:21

// Modified by: Bill James (2022-01-22T06:00:00Z)
// Method: RelatedGet
// Description
// Parameters
// ----------------------------------------------------

// MustFixQQQZZZ: Bill James (2022-01-22T06:00:00Z)
// Likely need to replace this everywhere, but converted here
var ptCurTable : Pointer
var $EndDate : Date
var $w : Integer
//TRACE
var $o : Object

$o:=ds:C1482.TallyMaster.query("purpose =  :1 & name = :2 & tableNum = :3"; "iLoRelate"; "RelateOnLoad"; Table:C252(ptCurTable)).first()

Case of 
	: (process.cur=Null:C1517)
		// skip all this if there is no record
		
	: ($o.id#Null:C1517)
		ExecuteText(0; $o.script)
	: (ptCurTable=(->[Customer:2]))
		
		RelateCustomer(1)
		
	: (ptCurTable=(->[Order:3]))
		//TRACE
		process_o.ents.Customer:=ds:C1482.Contact.query("customerID = :1"; process_o.cur.customerID)
		process_o.ents.Customer:=ds:C1482.Customer.query("customerID = :1"; process_o.cur.customerID)
		process_o.ents.Invoice:=ds:C1482.Invoice.query("orderNum = :1"; process_o.cur.orderNum)
		
		process_o.ents.LoadItem:=ds:C1482.LoadItem.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.LoadTag:=ds:C1482.LoadTag.query("orderNum = :1"; process_o.cur.orderNum)
		
		process_o.ents.Payment:=ds:C1482.Payment.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.POLine:=ds:C1482.POLine.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.PO:=ds:C1482.PO.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.Profile:=ds:C1482.Profile.query("tableNum = :1 & idForeign = :2"; viTableNum; process_o.cur.id)
		process_o.ents.Time:=ds:C1482.Time.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.Service:=ds:C1482.Service.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.WODraw:=ds:C1482.WODraw.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.WorkOrder:=ds:C1482.WorkOrder.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.QA:=ds:C1482.QA.query("orderNum = :1"; process_o.cur.orderNum)
		process_o.ents.Document:=ds:C1482.Document.query("orderNum = :1"; process_o.cur.orderNum)
		
		[Order:3]balanceDueEstimated:107:=[Order:3]total:27-Sum:C1(process_o.ents.Payment.amount)
		
		
	: (ptCurTable=(->[Invoice:26]))
		If ([Customer:2]customerID:1#[Invoice:26]customerID:3)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
		End if 
		
		If ([Invoice:26]idNumOrder:1#1)
			QUERY:C277([Service:6]; [Service:6]idNumInvoice:23=[Invoice:26]idNum:2; *)
			QUERY:C277([Service:6];  | [Service:6]idNumOrder:22=[Invoice:26]idNumOrder:1)
		Else 
			QUERY:C277([Service:6]; [Service:6]idNumInvoice:23=[Invoice:26]idNum:2)
		End if 
		Pay_InvoiceSrch
		PayLoadShow(Records in selection:C76([Payment:28]))
		READ ONLY:C145([LoadTag:88])
		READ ONLY:C145([LoadItem:87])
		QUERY:C277([LoadTag:88]; [LoadTag:88]idNumInvoice:19=[Invoice:26]idNum:2)
		QUERY:C277([LoadItem:87]; [LoadItem:87]invoiceNum:14=[Invoice:26]idNum:2)
		// Modified by: Bill James (2016-01-12T00:00:00 Subrecord eliminated)
		QUERY:C277([Ledger:30]; [Ledger:30]docRefid:4=[Invoice:26]idNum:2; *)
		QUERY:C277([Ledger:30];  & [Ledger:30]tableNum:3=Table:C252(->[Invoice:26]))
		QUERY:C277([Document:100]; [Document:100]idNumTask:21=[Invoice:26]idNumTask:78)
		
		
	: (ptCurTable=(->[Employee:19]))
		QUERY:C277([Territory:25]; [Territory:25]purpose:6=0; *)
		QUERY:C277([Territory:25];  & [Territory:25]salesNameID:1=[Employee:19]nameID:1)
		
		
		
	: (ptCurTable=(->[Item:4]))
		
		Item_GetSpec
		
		QUERY:C277([Usage:5]; [Usage:5]itemNum:1=[Item:4]type:26)
		
		QUERY:C277([Usage:5]; [Usage:5]itemNum:1=[Item:4]itemNum:1)
		QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNum:1=[Item:4]itemNum:1; *)
		QUERY:C277([ItemXRef:22];  | ; [ItemXRef:22]itemNumXRef:2=[Item:4]itemNum:1; *)  //### jwm ### 20121016_1242
		QUERY:C277([ItemXRef:22])  //### jwm ### 20121016_1242
		QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Item:4]itemNum:1)
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]itemNum:1=[Item:4]itemNum:1)
		
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]itemNum:12=[Item:4]itemNum:1; *)
		QUERY:C277([WorkOrder:66];  & [WorkOrder:66]woType:60="Transfer"; *)
		QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtComplete:6=0)
		iLoReal5:=Sum:C1([WorkOrder:66]qtyOrdered:13)
		
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]itemNum:12=[Item:4]itemNum:1)
		// display all WorkOrders
		QUERY:C277([ItemWarehouse:117]; [ItemWarehouse:117]itemNum:2=[Item:4]itemNum:1)
		QUERY:C277([ItemSiteBucket:136]; [ItemSiteBucket:136]itemNum:2=[Item:4]itemNum:1)
		iLoReal2:=Sum:C1([ItemSiteBucket:136]qtyOnHand:5)
		iLoReal1:=iLoReal2-[Item:4]qtyOnHand:14
		iLoReal4:=Sum:C1([ItemWarehouse:117]qtyOH:5)
		iLoReal3:=iLoReal4-[Item:4]qtyOnHand:14
		
		If (eProfilesItem>0)
			Profiles_Relate(eProfilesItem)  // ### jwm ### 20170804_1022
		End if 
		
		
		// MustFixQQQZZZ: Bill James (2022-01-22T06:00:00Z)
		// change to ORDA BOM
		
		$bom_o:=ds:C1482.BOM.query("childItem = :1"; process_o.cur.itemNum)
		
		If (eParentList>0)
			BOM_BuildMom  //array must be defined before defining the AreaList
			//  --  CHOPPED  BOM_ALDefineParent(eParentList; 0)
			//  --  CHOPPED  AL_UpdateArrays(eParentList; -2)
		End if 
		
		//### jwm ###   20090930
		//BOM_BuildExtend ([Item]ItemNum)
		
		var $bom_o; $wo_o; $qa_o : Object
		$bom_o:=ds:C1482.BOM.query("itemNum = :1"; process_o.cur.itemNum)
		
		// only do this from a form, not from the web
		If (eBOMList>0)
			[Item:4]bomHasChild:48:=False:C215  // reset in line 251 if there are children
			Bom_FillArray(0)
			//  CHOPPED  BOM_ALDefine(eBOMList; 0)
			If (bExtendedBOM=0)  //extended BOM is false
				//build single level BOM
				Bom_FillArray(Records in selection:C76([BOM:21]))
			Else   //extended BOM is true
				//build multi-level BOM
				BOM_BuildExtend([Item:4]itemNum:1)
			End if 
			If (Records in selection:C76([BOM:21])>0)
				[Item:4]bomHasChild:48:=True:C214
			End if 
		End if 
		
		
		
		
		var $doc_o; $wo_o; $qa_o : Object
		$doc_o:=ds:C1482.Document.query("idNumTask = :1"; process_o.cur.idNumTask)
		$wo_o:=ds:C1482.WorkOrder.query("itemNum = :1"; process_o.cur.itemNum)
		
		QUERY:C277([ItemPriceMatrix:105]; [ItemPriceMatrix:105]itemNum:11=[Item:4]itemNum:1)
		//PriceMatrix_FillArrays (Records in selection([PriceMatrix]))
		//QUERY([PriceMatrix];[PriceMatrix]ItemNum=[Item]ItemNum;*)
		//QUERY([PriceMatrix];&[PriceMatrix]TypeSale="Estimating")
		If (ePriceMatrixList>0)
			PriceMatrix_FillArrays(Records in selection:C76([ItemPriceMatrix:105]))
			
		End if 
		
		QUERY:C277([Document:100]; [Document:100]itemNum:20=[Item:4]itemNum:1)
		
		
	: (ptCurTable=(->[Usage:5]))
		var $beginSR; $endSR : Integer
		var $endDate : Date
		$endDate:=Date_ThisMon([Usage:5]periodDate:2; 1)
		$beginSR:=DateTime_DTTo([Usage:5]periodDate:2; ?00:00:00?)
		$endSR:=DateTime_DTTo($endDate; ?00:00:00?)
		QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Usage:5]itemNum:1; *)
		QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=$beginSR; *)
		QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<$endSR)
	: (ptCurTable=(->[UsageSummary:33]))
		RELATE MANY:C262([UsageSummary:33]periodDate:2)
	: (ptCurTable=(->[Rep:8]))
		QUERY:C277([Service:6]; [Service:6]repID:2=[Rep:8]repID:1)
		QUERY:C277([Quota:9]; [Quota:9]repID:1=[Rep:8]repID:1)
		QUERY:C277([zzzRepContact:10]; [zzzRepContact:10]repID:1=[Rep:8]repID:1)
		QUERY:C277([Order:3]; [Order:3]repID:8=[Rep:8]repID:1)
		QUERY:C277([Invoice:26]; [Invoice:26]repID:22=[Rep:8]repID:1)
		QUERY:C277([Proposal:42]; [Proposal:42]repID:7=[Rep:8]repID:1)
		QUERY:C277([Territory:25]; [Territory:25]purpose:6=0; *)
		QUERY:C277([Territory:25];  & [Territory:25]repID:2=[Rep:8]repID:1)
		ORDER BY:C49([Quota:9]; [Quota:9]period:3)
		LAST RECORD:C200([Quota:9])
		vPeriod:=[Quota:9]period:3
	: (ptCurTable=(->[Service:6]))
		If ([Service:6]customerID:1#"")
			Case of 
				: ([Service:6]contactID:52=0)
					//  CHOPPED  ContactsLoad(-1)
				: (([Service:6]contactID:52#0) & ([Service:6]contactID:52#[Contact:13]idNum:28))
					//QUERY([Contact];[Contact]UniqueID=[Service]contactID)
			End case 
			If (blockServiceRelate)
				BEEP:C151
				BEEP:C151
			Else 
				QUERY:C277([Order:3]; [Order:3]customerID:1=[Service:6]customerID:1)
				QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Service:6]customerID:1)
				QUERY:C277([Proposal:42]; [Proposal:42]customerID:1=[Service:6]customerID:1)
			End if 
		Else 
			If (Not:C34(blockServiceRelate))
				REDUCE SELECTION:C351([Order:3]; 0)
				REDUCE SELECTION:C351([Invoice:26]; 0)
				REDUCE SELECTION:C351([Proposal:42]; 0)
			End if 
		End if 
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]ideService:54=[Service:6]idNum:26)
		
		If ([Service:6]idNumTask:51>0)
			QUERY:C277([QA:70]; [QA:70]idNumTask:12=[Service:6]idNumTask:51)
			QUERY:C277([Document:100]; [Document:100]idNumTask:21=[Service:6]idNumTask:51)
		Else 
			REDUCE SELECTION:C351([WorkOrder:66]; 0)
			REDUCE SELECTION:C351([Document:100]; 0)
		End if 
	: (ptCurTable=(->[Contact:13]))
		QUERY:C277([Call:34]; [Call:34]tableNum:2=13; *)  //customer file number
		QUERY:C277([Call:34];  & [Call:34]customerID:1=String:C10([Contact:13]idNum:28))
		ORDER BY:C49([Call:34]; [Call:34]dtAction:4; <)
		//
		QUERY:C277([QA:70]; [QA:70]customerID:1=String:C10([Contact:13]idNum:28); *)
		QUERY:C277([QA:70]; [QA:70]tableNum:11=Table:C252(->[Contact:13]))
		//
		QUERY:C277([Document:100]; [Document:100]customerID:7=String:C10([Contact:13]idNum:28); *)
		QUERY:C277([Document:100];  & [Document:100]tableNum:6=Table:C252(->[Contact:13]))
		//
		QUERY:C277([Service:6]; [Service:6]contactID:52=[Contact:13]idNum:28)
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]contactID:30=[Contact:13]idNum:28)
		//
		QUERY:C277([Document:100]; [Document:100]customerID:7=String:C10([Contact:13]idNum:28); *)
		QUERY:C277([Document:100];  & [Document:100]tableNum:6=Table:C252(->[Contact:13]))
	: (ptCurTable=(->[Proposal:42]))
		QUERY:C277([Service:6]; [Service:6]idNumProposal:27=[Proposal:42]idNum:5)
		If ([Proposal:42]idNumTask:70>0)
			QUERY:C277([Document:100]; [Document:100]idNumTask:21=[Proposal:42]idNumTask:70)
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=[Proposal:42]idNumTask:70)
			QUERY:C277([QA:70]; [QA:70]idNumTask:12=[Proposal:42]idNumTask:70)
		Else 
			REDUCE SELECTION:C351([WorkOrder:66]; 0)
			REDUCE SELECTION:C351([Document:100]; 0)
			REDUCE SELECTION:C351([QA:70]; 0)
		End if 
		If (allowAlerts_boo)
			
			// MustFixQQQZZZ: Bill James (2022-01-22T06:00:00Z)
			// Build and show related
			var $doc_o; $wo_o; $qa_o : Object
			$doc_o:=ds:C1482.Document.query("idNumTask = :1"; process_o.cur.idNumTask)
			$wo_o:=ds:C1482.WorkOrder.query("idNumTask = :1"; process_o.cur.idNumTask)
			$qa_o:=ds:C1482.QA.query("idNumTask = :1"; process_o.cur.idNumTask)
			
		End if 
	: (ptCurTable=(->[PO:39]))
		QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
		QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
	: (ptCurTable=(->[Vendor:38]))
		QUERY:C277([PO:39]; [PO:39]vendorID:1=[Vendor:38]vendorID:1)
		PoArrayManage(-5)
		PoLnFillRays(0)
	: (ptCurTable=(->[POLine:40]))
		If ([POLine:40]idNumPO:1#[PO:39]idNum:5)
			QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
		End if 
		If ([Vendor:38]vendorID:1#[POLine:40]vendorID:24)
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
		End if 
	: (ptCurTable=(->[Usage:5]))
		$EndDate:=Date_ThisMon([Usage:5]periodDate:2; 1)
		QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Usage:5]itemNum:1; *)
		QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=DateTime_DTTo([Usage:5]periodDate:2; ?00:00:00?); *)
		QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=DateTime_DTTo($EndDate; ?23:59:59?))
		
	: (ptCurTable=(->[Payment:28]))
		QUERY:C277([DCash:62]; [DCash:62]docApply:3=[Payment:28]idNum:8; *)
		QUERY:C277([DCash:62];  & [DCash:62]tableApply:2="P"+"@")
	: (ptCurTable=(->[ItemSerial:47]))
		QUERY:C277([ItemSerialAction:64]; [ItemSerialAction:64]itemSerialid:1=[ItemSerial:47]idNum:18)
	: (ptCurTable=(->[QAQuestion:71]))
		QUERY:C277([QAAnswer:72]; [QAAnswer:72]idNumQAQuestion:1=[QAQuestion:71]idNum:1)
	: (ptCurTable=(->[Carrier:11]))
		REDUCE SELECTION:C351([zzzCarrierZone:143]; 0)
		QUERY:C277([zzzCarrierZone:143]; [zzzCarrierZone:143]idNumCarrier:6=[Carrier:11]idNum:44; *)
		If (([Carrier:11]siteID:36#"") & (Size of array:C274(<>asiteIDs)>1))
			QUERY:C277([zzzCarrierZone:143]; [zzzCarrierZone:143]siteID:8=[Carrier:11]siteID:36; *)
		End if 
		QUERY:C277([zzzCarrierZone:143])
		ORDER BY:C49([zzzCarrierZone:143]; [zzzCarrierZone:143]zipLow:1)
		REDUCE SELECTION:C351([zzzCarrierWeight:144]; 0)
		QUERY:C277([zzzCarrierWeight:144]; [zzzCarrierWeight:144]idNumCarrier:13=[Carrier:11]idNum:44)
		ORDER BY:C49([zzzCarrierWeight:144]; [zzzCarrierWeight:144]weight:1)
	: (ptCurTable=(->[EventLog:75]))
		QUERY:C277([zzzWebTempRec:101]; [zzzWebTempRec:101]idEventLog:1=[EventLog:75]idNum:5)
	: (ptCurTable=(->[ItemCatalog:44]))  // ### jwm ### 20171219_1447
		QUERY:C277([ItemCatalogLine:45]; [ItemCatalogLine:45]specialDiscountsid:1=[ItemCatalog:44]idNum:4)
		
End case 



