//%attributes = {}

// Modified by: Bill James (2023-03-24T05:00:00Z)
// Method: 019LinesConvert
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($dataClassName : Text)
If ($dataClassName#"")
	
	var $rec_e; $sel_e; $recLine_e; $selLine_e : Object
	$sel_e:=ds:C1482[$dataClassName].all()
	For each ($rec_e; $sel_e)
		$rec_e.lines:=New object:C1471
		
	End for each 
Else 
	
	var $rec_e; $sel_e : Object
	$sel_e:=ds:C1482.Order.all()
	For each ($rec_e; $sel_e)
		
	End for each 
	
	// LoadTags   LoadItem
	// Popup
	// Order      OrderLine
	// Proposal   
	// Invoice
	// PO
	// Invoice
	// Requisition
	// ItemSerial   ItemSerialAction
	// WorkOrder    WorkOrderLine
	// Process      Attribute    Cause
	// Objective
	// --Payment
End if 