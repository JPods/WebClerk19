//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/11/13, 10:33:01
// ----------------------------------------------------
// Method: WOTransfers_Sort
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $diplay)
$diplay:=$1
Case of 
	: (Records in selection:C76([WorkOrder:66])<2)
		// skip
	: (iLoText2="View")
		
		ORDER BY:C49([WorkOrder:66]Action:33; <; [WorkOrder:66]woNum:29; <)
		
	: (iLoText2="Request")
		
		ORDER BY:C49([WorkOrder:66]Action:33; <; [WorkOrder:66]woNum:29; <)
		
	: (iLoText2="Ship")
		ORDER BY:C49([WorkOrder:66]Action:33; <; [WorkOrder:66]woNum:29; <)
		
	Else   //: (iLoText2="Receive")
		
		ORDER BY:C49([WorkOrder:66]Action:33; <; [WorkOrder:66]woNum:29; <)
End case 