//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-27T00:00:00, 22:45:40
// ----------------------------------------------------
// Method: ProposalLinesBody
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
		REDUCE SELECTION:C351([ProposalLine:43]; 0)
		REDUCE SELECTION:C351([Item:4]; 0)
		REDUCE SELECTION:C351([ItemSpec:31]; 0)
		P_clearLineVariables
	: (aPrintBodyCount{vPrintBodyCounter}>-1)
		GOTO RECORD:C242([ProposalLine:43]; aPrintBodyCount{vPrintBodyCounter})
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
		Item_GetSpec
		C_LONGINT:C283($w)
		If ([ProposalLine:43]idUnique:52=0)
			$w:=Find in array:C230(aPSeq; [ProposalLine:43]sequence:33)
			//
			//save record([ProposalLine])    // ????? fix this else where
		Else 
			$w:=Find in array:C230(aPUniqueID; [ProposalLine:43]idUnique:52)
		End if 
		If ($w>0)
			P_PpLines2PVars($w)
		Else 
			REDUCE SELECTION:C351([QQQPOLine:40]; 0)
			REDUCE SELECTION:C351([Item:4]; 0)
			REDUCE SELECTION:C351([ItemSpec:31]; 0)
			P_clearLineVariables
		End if 
	Else 
		REDUCE SELECTION:C351([QQQPOLine:40]; 0)
		REDUCE SELECTION:C351([Item:4]; 0)
		REDUCE SELECTION:C351([ItemSpec:31]; 0)
		P_clearLineVariables
End case 
If (vPrintBodyCounter=Size of array:C274(aPrintBodyCount))  // call each time the number of lines reaches the number per page
	vPrintBodyCounter:=0
	//  vPageCurrent:=vPageCurrent+1
	//pvPage:="Order "+String([Order]OrderNum;"0000-0000")+":  Page "+String(vPageCurrent)+" of "+String(vPagesTotal)
	//  p_Page:=pvPage
End if 

