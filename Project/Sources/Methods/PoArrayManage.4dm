//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/21/07, 12:07:43
// ----------------------------------------------------
// Method: PoArrayManage
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $2; $3; $4)
Case of 
	: ($1>-1)
		ARRAY LONGINT:C221(aPOs; $1)
		ARRAY TEXT:C222(aVendors; $1)
		ARRAY DATE:C224(aPODate; $1)
		ARRAY REAL:C219(aPOTotal; $1)
		ARRAY REAL:C219(aPOOpenAmt; $1)
		ARRAY TEXT:C222(aPOShipTo; $1)
		ARRAY TEXT:C222(aPOShipTo; $1)
		ARRAY TEXT:C222(aPOStatus; $1)
		ARRAY TEXT:C222(aPOStatusVendor; $1)
		ARRAY TEXT:C222(aPOAttn; $1)
		ARRAY TEXT:C222(aPOCustomerRef; $1)
		ARRAY LONGINT:C221(aPORecs; $1)
		ARRAY LONGINT:C221(aPOSONum; $1)
		ARRAY TEXT:C222(aPOBuyer; $1)
		
		
	: ($1=-5)
		If (<>viPOByOrderDate=1)
			SELECTION TO ARRAY:C260([PO:39]; aPORecs; [PO:39]buyer:7; aPOBuyer; [PO:39]statusVendor:70; aPOStatusVendor; [PO:39]status:52; aPOStatus; [PO:39]idNum:5; aPOs; [PO:39]vendorCompany:39; aVendors; [PO:39]dateOrdered:2; aPODate; [PO:39]amount:19; aPOTotal; [PO:39]amountBackLog:25; aPOOpenAmt; [PO:39]shipToCompany:8; aPOShipTo; [PO:39]attention:26; aPOAttn; [PO:39]refCustomer:47; aPOCustomerRef; [PO:39]idNumOrder:18; aPOSONum)
			
		Else 
			SELECTION TO ARRAY:C260([PO:39]; aPORecs; [PO:39]buyer:7; aPOBuyer; [PO:39]statusVendor:70; aPOStatusVendor; [PO:39]status:52; aPOStatus; [PO:39]idNum:5; aPOs; [PO:39]vendorCompany:39; aVendors; [PO:39]dateNeeded:3; aPODate; [PO:39]amount:19; aPOTotal; [PO:39]amountBackLog:25; aPOOpenAmt; [PO:39]shipToCompany:8; aPOShipTo; [PO:39]attention:26; aPOAttn; [PO:39]refCustomer:47; aPOCustomerRef; [PO:39]idNumOrder:18; aPOSONum)
			
		End if 
		
		aPORecs:=0
		If (ePOs#0)
			//  --  CHOPPED  AL_UpdateArrays(ePOs; -2)
			If (aPORecs=1)
				// -- AL_SetLine(ePOs; 1)
				// -- AL_SetScroll(ePOs; 1; 1)
			End if 
		End if 
		REDUCE SELECTION:C351([POLine:40]; 0)
		PoLnFillRays(0)
		If (ePoLines#0)
			//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
		End if 
		
End case 
