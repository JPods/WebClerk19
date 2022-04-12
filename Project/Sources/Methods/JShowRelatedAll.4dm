//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/04/18, 21:51:31
// ----------------------------------------------------
// Method: JShowRelatedAll
// Description
// 
//
// Parameters
// ----------------------------------------------------


// MustFixQQQZZZ: Bill James (2021-12-10T06:00:00Z)


C_POINTER:C301($1; $myPtr)
If (Count parameters:C259=0)
	$myPtr:=ptCurTable
Else 
	$myPtr:=$1
End if 
Case of 
	: (vHere#1)
		ALERT:C41("Must be in an output layout.")
	: (ptCurTable=(->[Customer:2]))
		Cust_ShowRelate
		//    
	: ($myPtr=(->[Invoice:26]))
		BEEP:C151
		//
	: ($myPtr=(->[Order:3]))
		Ord_ShowRelated
		//
	: ($myPtr=(->[Proposal:42]))
		//ShowRelated_Pp
		//
	: ($myPtr=(->[Contact:13]))
		//ShowRelated_Contact
		BEEP:C151
	: ($myPtr=(->[Reference:7]))
		BEEP:C151
	: ($myPtr=(->[DCash:62]))
		BEEP:C151
	: ($myPtr=(->[Ledger:30]))
		
		//End if 
		BEEP:C151
	: ($myPtr=(->[Word:99]))
		RelateByNumbers(Table:C252($myPtr))
	: ($myPtr=(->[ProposalLine:43]))
		BEEP:C151
	: ($myPtr=(->[Lead:48]))
		BEEP:C151
	: ($myPtr=(->[Payment:28]))
		Cust_ShowRelate
	: ($myPtr=(->[InvoiceLine:54]))
		BEEP:C151
	: ($myPtr=(->[OrderLine:49]))
		BEEP:C151
	: ($myPtr=(->[QA:70]))
		BEEP:C151
	: ($myPtr=(->[QAAnswer:72]))
		BEEP:C151
	: ($myPtr=(->[Rep:8]))
		BEEP:C151
	: ($myPtr=(->[Item:4]))
		BEEP:C151
		//
	: ($myPtr=(->[Project:24]))
		BEEP:C151
		//
	: ($myPtr=(->[PO:39]))
		BEEP:C151
	: ($myPtr=(->[POLine:40]))
		BEEP:C151
		//  
	: ($myPtr=(->[Vendor:38]))
		BEEP:C151
		//
	: ($myPtr=(->[InventoryStack:29]))
		BEEP:C151
	: ($myPtr=(->[BOM:21]))
		BEEP:C151
	: ($myPtr=(->[ItemSpec:31]))
		BEEP:C151
	: ($myPtr=(->[ItemXRef:22]))
		BEEP:C151
	: ($myPtr=(->[DInventory:36]))
		BEEP:C151
	: ($myPtr=(->[WorkOrder:66]))
		QUERY:C277([WorkOrderEvent:121]; [WorkOrderEvent:121]woNum:5=[WorkOrder:66]woNum:29)
		WOEvents_FillArrays(Records in selection:C76([WorkOrderEvent:121]))
		REDUCE SELECTION:C351([WorkOrderEvent:121]; 0)
		If (eWOEvents>0)
			//  --  CHOPPED  AL_UpdateArrays(eWOEvents; -2)
		End if 
		QUERY:C277([WorkOrderTask:67]; [WorkOrderTask:67]woNum:10=[WorkOrder:66]woNum:29)
		WoTasksFillArrays(Records in selection:C76([WorkOrderTask:67]))
		WOTasks_ALDefine(eWOTasks; 1)
		REDUCE SELECTION:C351([WorkOrderTask:67]; 0)
		//  --  CHOPPED  AL_UpdateArrays(eWOTasks; -2)
		If (eWOTasks>0)
			//  --  CHOPPED  AL_UpdateArrays(eWOTasks; -2)
		End if 
	: ($myPtr=(->[WOTemplate:69]))
		BEEP:C151
	: ($myPtr=(->[WODraw:68]))
		BEEP:C151
	: ($myPtr=(->[WorkOrderTask:67]))
		BEEP:C151
	: ($myPtr=(->[TechNote:58]))
		BEEP:C151
	: ($myPtr=(->[UsageSummary:33]))
		BEEP:C151
	: ($myPtr=(->[Usage:5]))
		BEEP:C151
	: ($myPtr=(->[Service:6]))
		BEEP:C151
	: ($myPtr=(->[Default:15]))
		BEEP:C151
	: ($myPtr=(->[CallReport:34]))
		BEEP:C151
	: ($myPtr=(->[GenericParent:89]))
		BEEP:C151
	: ($myPtr=(->[GenericChild1:90]))
		BEEP:C151
	: ($myPtr=(->[GenericChild2:91]))
		BEEP:C151
	Else 
		BEEP:C151
End case 