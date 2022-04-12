//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-27T00:00:00, 22:46:23
// ----------------------------------------------------
// Method: POLinesBody
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
		GOTO RECORD:C242([QQQPOLine:40]; aPrintBodyCount{vPrintBodyCounter})
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[QQQPOLine:40]itemNum:2)
		Item_GetSpec
		
		C_TEXT:C284($1; $doStack1)
		$doStack1:=""
		If ($doStack1#"")
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="P_PoLines2PVars"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Name:8=$doStack1)
			If (Records in selection:C76([TallyMaster:60])=1)
				ExecuteText(0; [TallyMaster:60]Script:9)
			End if 
		End if 
		C_LONGINT:C283($w)
		$w:=Find in array:C230(aPoUniqueID; [QQQPOLine:40]idUnique:32)
		If ($w>0)
			P_PoLines2PVars($w)
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
	//  pvPage:="Order "+String([Order]OrderNum;"0000-0000")+":  Page "+String(vPageCurrent)+" of "+String(vPagesTotal)
	//  p_Page:=pvPage
End if 


