//%attributes = {}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/19/13, 15:43:20
// ----------------------------------------------------
// Method: Object Method: ItemNum
// Description
// File: Object Method: [WorkOrder]iWorkOrders_9.ItemNum.txt
// Parameters
// ----------------------------------------------------

//iLo WorkOrders_9
//Script: PartKey

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-05-28T00:00:00, 13:31:48
// ----------------------------------------------------
// Method: WorkOrderClearInvoiceLine
// Description
// Modified: 05/28/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// Modified by: Bill James (2015-05-28T00:00:00 Subrecord eliminated)

KeyModifierCurrent
//TRACE
QUERY:C277([Item:4]; [Item:4]itemNum:1=[WorkOrder:66]itemNum:12)
If (Records in selection:C76([Item:4])=1)
	pPartNum:=[Item:4]itemNum:1
	WOLnFillItem(pPartNum; -5)
	If ([WorkOrder:66]idNumInvoice:1#0)
		QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=[WorkOrder:66]idNumInvoice:1)
		If ([Invoice:26]jrnlComplete:48)
			ALERT:C41("Invoice Journalized, no changes allowed.")
		Else 
			LOAD RECORD:C52([Invoice:26])
			If (Locked:C147([Invoice:26]))
				ALERT:C41("Invoice is locked and cannot be changes at this time.")
			Else 
				CONFIRM:C162("Change Item Number on WorkOrder and Invoice to: "+[WorkOrder:66]itemNum:12)
				If (OK=1)
					C_LONGINT:C283($i; $k)
					QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
					$k:=Records in selection:C76([InvoiceLine:54])
					FIRST RECORD:C50([InvoiceLine:54])
					IVNT_dRayInit
					For ($i; 1; $k)
						If ([InvoiceLine:54]location:22=[WorkOrder:66]idNum:29)
							Invt_dRecCreate("IV"; [Invoice:26]idNum:2; [Invoice:26]idNumOrder:1; [Invoice:26]customerID:3; [WorkOrder:66]idNum:29; "Inv -dWO"; 1; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; [InvoiceLine:54]qty:7; 0; [InvoiceLine:54]unitCost:12; ""; vsiteID; [WorkOrder:66]unitCost:19)
							[InvoiceLine:54]itemNum:4:=[WorkOrder:66]itemNum:12
							Invt_dRecCreate("IV"; [Invoice:26]idNum:2; [Invoice:26]idNumOrder:1; [Invoice:26]customerID:3; [WorkOrder:66]idNum:29; "Inv +dWO"; 1; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; -[InvoiceLine:54]qty:7; 0; [InvoiceLine:54]unitCost:12; ""; vsiteID; [WorkOrder:66]unitCost:19)
							
							$i:=$k
							SAVE RECORD:C53([Invoice:26])
						Else 
							NEXT RECORD:C51([InvoiceLine:54])
						End if 
					End for 
					
					INVT_dInvtApply
					
					IVNT_dRayInit
					
				End if 
			End if 
		End if 
	End if 
	If (([WorkOrder:66]description:3="") | (OptKey=1))
		Item_GetSpec
		C_LONGINT:C283($p)
		[WorkOrder:66]description:3:=[ItemSpec:31]specification:2
		$p:=Position:C15("<&"; [WorkOrder:66]description:3)
		If ($p>0)
			[WorkOrder:66]description:3:=Txt_jitConvert([WorkOrder:66]description:3)
		End if 
	End if 
	UNLOAD RECORD:C212([ItemSpec:31])
	UNLOAD RECORD:C212([Item:4])
Else 
	BEEP:C151
	BEEP:C151
End if 
