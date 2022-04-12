//%attributes = {}
// Script OnOpen GenericParent 20140610

If ([GenericParent:89]name:2="940")
	OBJECT SET TITLE:C194(*; "Text92"; "FDI Order")
	OBJECT SET TITLE:C194(*; "Text93"; "ITS Order")
	OBJECT SET TITLE:C194(*; "Text94"; "Status")
	OBJECT SET TITLE:C194(*; "Text95"; "BOL")
	OBJECT SET TITLE:C194(*; "Text96"; "Customer PO")
	OBJECT SET TITLE:C194(*; "Bool01"; "Test")
	OBJECT SET TITLE:C194(*; "Bool02"; "Locked")
	OBJECT SET TITLE:C194(*; "Bool03"; "Error")
	OBJECT SET TITLE:C194(*; "Text110"; "Shipped")
	OBJECT SET TITLE:C194(*; "Text111"; "Processed")
	OBJECT SET TITLE:C194(*; "Text122"; "dtProcessed")
	OBJECT SET TITLE:C194(*; "Text134"; "ISA")
	OBJECT SET TITLE:C194(*; "Text135"; "GS")
	OBJECT SET TITLE:C194(*; "Text136"; "Invoice")
	OBJECT SET TITLE:C194(*; "Text153"; "Freight Cost")
	OBJECT SET TITLE:C194(*; "Text163"; "Comments")
	OBJECT SET TITLE:C194(*; "Text164"; "EDI")
	OBJECT SET TITLE:C194(*; "Text128"; "Processed")
	OBJECT SET TITLE:C194(*; "Text129"; "PackInvoice")
	OBJECT SET TITLE:C194(*; "Text130"; "PackBox")
	OBJECT SET TITLE:C194(*; "Text131"; "PackLineItem")
	OBJECT SET TITLE:C194(*; "Text132"; "PKBoxItemsTags")
	OBJECT SET TITLE:C194(*; "Text133"; "PKOrderLoad")
	
	// [GenericParent]A40_01// Shipment Identification Number
	// [GenericParent]A40_02// Agent Shipment ID Number
	// [GenericParent]A40_03// Status
	// [GenericParent]A40_04// BOL Number
	// [GenericParent]A40_05// PO Number
	// [GenericParent]Bool01// Test Document
	// [GenericParent]Bool02// Locked Order
	// [GenericParent]Bool03// ERROR / FAIL
	// [GenericParent]customerID// customerID
	// [GenericParent]D01// DateShipped
	// [GenericParent]D02// Current Date (Processed)
	// [GenericParent]UniqueID// Order Number
	// [GenericParent]LI01// ISA Control Number
	// [GenericParent]LI02// GS Control Number
	// [GenericParent]LI03// Invoice Number
	// [GenericParent]R01// Freight Cost
	// [GenericParent]T01// Process Comments
	// [GenericParent]T02// EDI Document
	// [GenericParent]TableNum// Orders Table ID
	// [GenericParent]UniqueID// UniqueID
	// [GenericParent]H01// Current Time
	// [GenericParent]H02// Elapsed Time PackInvoice.4d
	// [GenericParent]H03// Elapsed Time PackBox.4d
	// [GenericParent]H04// Elapsed Time PackLineItem.4d
	// [GenericParent]H05// Elapsed Time PKBoxItemsTags
	// [GenericParent]H06// Elapsed Time PkOrderLoad
	
End if 