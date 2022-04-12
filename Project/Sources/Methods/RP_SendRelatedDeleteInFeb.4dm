//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/13/19, 13:17:20
// ----------------------------------------------------
// Method: RP_SendRelated
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20190113_1320
// not called anywhere. Keep until 2019-02-15
Case of 
	: ($ptTable=(->[Item:4]))
		If (DefaultSetupsReturnValue("RPRelatedItems")="true")
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
			QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1=[Item:4]itemNum:1)
			QUERY:C277([BOM:21]; [BOM:21]itemNum:1=[Item:4]itemNum:1)
			QUERY:C277([Document:100]; [Document:100]itemNum:20=[Item:4]itemNum:1)
			
			
		End if 
		
	: ($ptTable=(->[Customer:2]))
		If (DefaultSetupsReturnValue("RPRelatedCustomers")="true")
			QUERY:C277([QA:70]; [QA:70]customerID:1=[Customer:2]customerID:1)
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
			QUERY:C277([Document:100]; [Document:100]customerID:7=[Customer:2]customerID:1)
			
			
			
		End if 
	: ($ptTable=(->[WorkOrder:66]))
		If (DefaultSetupsReturnValue("RPRelatedWorkOrders")="true")
			QUERY:C277([WorkOrderTask:67]; [WorkOrderTask:67]woNum:10=[WorkOrder:66]woNum:29)
			
			
			
		End if 
	: ($ptTable=(->[Order:3]))
		If (DefaultSetupsReturnValue("RPRelatedOrders")="true")
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
			QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
			QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
			QUERY:C277([Invoice:26]; [Invoice:26]orderNum:1=[Order:3]orderNum:2)
			
			If ([Order:3]taskid:85#0)
				QUERY:C277([QA:70]; [QA:70]taskid:12=[Order:3]taskid:85)
				
			End if 
			
		End if 
	: ($ptTable=(->[Invoice:26]))
		If (DefaultSetupsReturnValue("RPRelatedInvoices")="true")
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
			
			
			
			If ([Invoice:26]taskid:78#0)
				QUERY:C277([QA:70]; [QA:70]taskid:12=[Invoice:26]taskid:78)
				
				
			End if 
			
			QUERY:C277([Payment:28]; [Payment:28]invoiceNum:3=[Invoice:26]invoiceNum:2)
			
			
			
			
		End if 
	: ($ptTable=(->[Proposal:42]))
		If (DefaultSetupsReturnValue("RPRelatedProposals")="true")
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
			
			
			
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
			
			
			
			If ([Proposal:42]taskid:70#0)
				QUERY:C277([QA:70]; [QA:70]taskid:12=[Proposal:42]taskid:70)
				
				
			End if 
		End if 
End case 




