//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 12:59:34
// ----------------------------------------------------
// Method: ConsolidateRecs
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(vHere)
C_POINTER:C301($1; $3; $2)
C_BOOLEAN:C305($4; $0)
C_LONGINT:C283($i; $k; $subii; $subkk)
If (Record number:C243($1->)>-1)
	$0:=True:C214
	If (Count parameters:C259=3)
		If (allowAlerts_boo)
			CONFIRM:C162("Change history to new code?!? This cannot be undone.")
		Else 
			OK:=1
		End if 
		$0:=(OK=1)
	End if 
	If (OK=1)
		Case of 
			: ($1=(->[Customer:2]))
				READ WRITE:C146([Ledger:30])
				READ WRITE:C146([ProposalLine:43])
				READ WRITE:C146([OrderLine:49])
				READ WRITE:C146([InvoiceLine:54])
				READ WRITE:C146([DCash:62])
				ConsolidateFile($2; $3; ->[Contact:13]customerID:1; ->[Order:3]customerID:1; ->[Invoice:26]customerID:3; ->[Service:6]customerID:1; ->[Reference:7]customerID:1; ->[Proposal:42]customerID:1; ->[Payment:28]customerID:4)
				ConsolidateFile($2; $3; ->[ItemSerial:47]customerID:9; ->[Ledger:30]customerID:1; ->[InvoiceLine:54]customerID:2; ->[OrderLine:49]customerID:2; ->[ProposalLine:43]customerID:42; ->[DCash:62]customerIDApply:1)
				ConsolidateFile($2; $3; ->[DCash:62]customerIDReceive:7)
				READ ONLY:C145([Ledger:30])
				READ ONLY:C145([ProposalLine:43])
				READ ONLY:C145([OrderLine:49])
				READ ONLY:C145([InvoiceLine:54])
				READ ONLY:C145([DCash:62])
				QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=2; *)
				QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerID:10=$2->)
				//QUERY([RemoteUser];&[RemoteUser]UniqueID=$2->)   //### jwm ### 20130131_2128
				
				ConsolidateAccountID(->[RemoteUser:57]customerID:10; $3)
				
				QUERY:C277([CommunicationDevice:63]; [CommunicationDevice:63]tableNum:2=2; *)
				QUERY:C277([CommunicationDevice:63];  & [CommunicationDevice:63]customerID:1=$2->)
				
				ConsolidateAccountID(->[CommunicationDevice:63]customerID:1; $3)
				
				QUERY:C277([QA:70]; [QA:70]tableNum:11=2; *)
				QUERY:C277([QA:70];  & [QA:70]customerID:1=$2->)
				ConsolidateAccountID(->[QA:70]customerID:1; $3)
				
				QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=2; *)
				QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=$2->)
				
				ConsolidateAccountID(->[CallReport:34]customerID:1; $3)
				
			: ($1=(->[Item:4]))
				
				READ WRITE:C146([ItemSpec:31])
				ConsolidateFile($2; $3; ->[ItemSpec:31]itemNum:1)
				// ### bj ### 20200626_1856
				
				READ WRITE:C146([BOM:21])
				ConsolidateFile($2; $3; ->[BOM:21]childItem:2; ->[BOM:21]itemNum:1)
				
				READ WRITE:C146([CallReport:34])
				READ WRITE:C146([Document:100])
				READ WRITE:C146([Discussion:139])
				READ WRITE:C146([DInventory:36])
				ConsolidateFile($2; $3; ->[CallReport:34]itemNum:24; ->[Document:100]itemNum:20; ->[Discussion:139]itemNum:8; ->[DInventory:36]itemNum:1)
				
				READ WRITE:C146([GenericChild1:90])
				READ WRITE:C146([GenericChild2:91])
				READ WRITE:C146([GenericParent:89])
				ConsolidateFile($2; $3; ->[GenericChild1:90]itemNum:56; ->[GenericChild2:91]itemNum:43; ->[GenericParent:89]itemNum:82)
				
				READ WRITE:C146([InventoryStack:29])
				READ WRITE:C146([InvoiceLine:54])
				ConsolidateFile($2; $3; ->[InventoryStack:29]itemNum:2; ->[InvoiceLine:54]itemNum:4)
				
				READ WRITE:C146([ItemDiscount:45])
				READ WRITE:C146([ItemSerial:47])
				READ WRITE:C146([InvoiceLine:54])
				ConsolidateFile($2; $3; ->[ItemDiscount:45]itemNum:2; ->[ItemXRef:22]itemNumMaster:1; ->[ItemSerial:47]itemNum:1; ->[OrderLine:49]itemNum:4; ->[POLine:40]itemNum:2; ->[ProposalLine:43]itemNum:2)
				
				READ WRITE:C146([ItemDiscount:45])
				READ WRITE:C146([ItemModifier:120])
				ConsolidateFile($2; $3; ->[ItemDiscount:45]itemNum:2; ->[ItemModifier:120]itemNum:22)
				
				READ WRITE:C146([ItemCarried:113])
				READ WRITE:C146([ItemSerialAction:64])
				READ WRITE:C146([ItemSerial:47])
				ConsolidateFile($2; $3; ->[ItemCarried:113]itemNum:2; ->[ItemSerialAction:64]itemNum:8; ->[ItemSerial:47]itemNum:1)
				
				READ WRITE:C146([ItemSiteBucket:136])
				READ WRITE:C146([ItemWarehouse:117])
				READ WRITE:C146([ItemXRef:22])
				ConsolidateFile($2; $3; ->[ItemWarehouse:117]itemNum:2; ->[ItemSiteBucket:136]itemNum:2; ->[ItemXRef:22]itemNumMaster:1; ->[ItemXRef:22]itemNumXRef:2)
				
				READ WRITE:C146([LoadItem:87])
				ConsolidateFile($2; $3; ->[LoadItem:87]itemNum:3; ->[LoadItem:87]itemNumAlt:12)
				
				READ WRITE:C146([Menu:107])
				ConsolidateFile($2; $3; ->[Menu:107]childValue:6)
				
				READ WRITE:C146([OrderLine:49])
				READ WRITE:C146([POLine:40])
				READ WRITE:C146([ProposalLine:43])
				READ WRITE:C146([PriceMatrix:105])
				ConsolidateFile($2; $3; ->[OrderLine:49]itemNum:4; ->[POLine:40]itemNum:2; ->[POLine:40]altItemNum:20; ->[ProposalLine:43]itemNum:2; ->[PriceMatrix:105]itemNum:11)
				// [ProposalLine]AltItemNum
				// [OrderLine]AltItem
				
				READ WRITE:C146([Requisition:83])
				READ WRITE:C146([Reservation:79])
				READ WRITE:C146([Service:6])
				ConsolidateFile($2; $3; ->[Requisition:83]itemNum:38; ->[Reservation:79]itemNum:1; ->[Service:6]itemNum:70)
				
				READ WRITE:C146([TechNote:58])
				READ WRITE:C146([TallyResult:73])
				READ WRITE:C146([TallySummary:77])
				ConsolidateFile($2; $3; ->[TechNote:58]itemNum:27; ->[TallyResult:73]itemNum:34; ->[TallySummary:77]itemNum:15)
				
				READ WRITE:C146([Usage:5])
				READ WRITE:C146([UsageSummary:33])
				READ WRITE:C146([UUIDConnection:155])
				ConsolidateFile($2; $3; ->[Usage:5]itemNum:1; ->[UsageSummary:33]itemNum:34; ->[UUIDConnection:155]itemNum:13)
				
				READ WRITE:C146([WebTempRec:101])
				READ WRITE:C146([WorkOrder:66])
				READ WRITE:C146([WODraw:68])
				READ WRITE:C146([WorkOrderTask:67])
				READ WRITE:C146([WOTemplate:69])
				ConsolidateFile($2; $3; ->[WebTempRec:101]itemNum:3; ->[WorkOrder:66]itemNum:12; ->[WODraw:68]itemNum:2; ->[WorkOrderTask:67]itemNum:1; ->[WOTemplate:69]itemNum:1)
				
				
				READ ONLY:C145([ItemSerial:47])
				READ WRITE:C146([OrderLine:49])
				READ WRITE:C146([InvoiceLine:54])
				READ ONLY:C145([POLine:40])
				READ ONLY:C145([ProposalLine:43])
				READ ONLY:C145([ItemSerialAction:64])
				If (allowAlerts_boo)
					ALERT:C41("History Change is complete for "+$2->+" to "+$3->)
				End if 
				FLUSH CACHE:C297
			Else 
				If (allowAlerts_boo)
					ALERT:C41("This procedure does not apply to this file.")
				End if 
		End case 
		
		If (allowAlerts_boo)
			ALERT:C41("History Change Complete")  // ### jwm ### 20161014_1632
		End if 
		
	Else 
		$3->:=$2->
	End if 
Else 
	If (allowAlerts_boo)
		ALERT:C41("This is a new record, cancel and go to the original record.")
	End if 
	$3->:=$2->
End if 
UNLOAD RECORD:C212([BOM:21])
UNLOAD RECORD:C212([ItemXRef:22])
UNLOAD RECORD:C212([InventoryStack:29])
UNLOAD RECORD:C212([ItemSpec:31])
UNLOAD RECORD:C212([DInventory:36])
UNLOAD RECORD:C212([ItemSerial:47])

UNLOAD RECORD:C212([Usage:5])
UNLOAD RECORD:C212([ItemSerialAction:64])
UNLOAD RECORD:C212([WorkOrder:66])
UNLOAD RECORD:C212([WODraw:68])

UNLOAD RECORD:C212([OrderLine:49])
UNLOAD RECORD:C212([InvoiceLine:54])
UNLOAD RECORD:C212([POLine:40])
UNLOAD RECORD:C212([ProposalLine:43])
If (vHere>1)
	RelatedRelease
End if 