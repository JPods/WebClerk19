//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-27T00:00:00, 22:47:04
// ----------------------------------------------------
// Method: OrderLinesBody
// Description
// Modified: 03/27/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


vPrintBodyCounter:=vPrintBodyCounter+1  // count up for the number of elements in aPrintBodyCount
Case of 
	: (vPrintBodyCounter>Size of array:C274(aPrintBodyCount))  //  this should not happen. Added for protection
		REDUCE SELECTION:C351([OrderLine:49]; 0)
		REDUCE SELECTION:C351([Item:4]; 0)
		REDUCE SELECTION:C351([ItemSpec:31]; 0)
		P_clearLineVariables
	: (aPrintBodyCount{vPrintBodyCounter}>-1)
		GOTO RECORD:C242([OrderLine:49]; aPrintBodyCount{vPrintBodyCounter})
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
		Item_GetSpec
		P_OrdLines2PVars
	Else 
		REDUCE SELECTION:C351([OrderLine:49]; 0)
		REDUCE SELECTION:C351([Item:4]; 0)
		REDUCE SELECTION:C351([ItemSpec:31]; 0)
		P_clearLineVariables
End case 

If (vPrintBodyCounter=Size of array:C274(aPrintBodyCount))  // call each time the number of lines reaches the number per page
	vPrintBodyCounter:=0
	//  vPageCurrent:=vPageCurrent+1
	//  pvPage:="Order "+String([Order]OrderNum;"0000-0000")+":  Page "+String(vPageCurrent)+" of "+String(vPagesTotal)
	//  p_Page:=pvPage
End if 