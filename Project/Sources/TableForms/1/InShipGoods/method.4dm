Case of 
	: (Outside call:C328)
		Prs_OutsideCall
	: ((Before:C29) | (booPreNext))
		C_LONGINT:C283($k; $i; $gotoLine)
		C_BOOLEAN:C305($doSort; vLineMod)
		C_LONGINT:C283(srPO)
		myOK:=0
		viRecordsInSelection:=0
		ARRAY LONGINT:C221(aRayLines; 0)
		bNewRec:=0
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Receiving")
		ARRAY LONGINT:C221(aPoLnSelct; 0)
		//   Pict_InputLo ([Control];1;-30)//get PICT resc 21006    
		//figuar this out
		doSearch:=0
		vsVendorInvoiceNum:=""
		vdVendorInvoiceDate:=Current date:C33
		vrVendorInvoiceFreight:=0
		vrVendorInvoiceAmount:=0
		b31:=1  //New ReceiptID every Save
		vlReceiptID:=-1
		iLoReal1:=0
		iLoReal2:=0
		iLoReal3:=0
		iLoReal4:=0
		iLoReal10:=0
		vsiteID:=DSGetMachineSiteID  //### jwm ### 20130220_1511
		// TRACE
		//  CHOPPED MM_SetDate(ePopDate; Current date)
		PoLnFillRays(0)
		REDUCE SELECTION:C351([PO:39]; 0)
		PoArrayManage(-5)
		POALDefine
		// -- AL_SetRowOpts(ePOs; 0; 0; 0; 0; 1)  //reset this item.
		//  CHOPPED  POLineALDefine(ePoLines)
		
		// -- AL_SetHdrStyle(ePoLines; 1; "Geneva"; 9; 2)  //Item Number
		// -- AL_SetWidths(ePoLines; 1; 12; 80; 3; 43; 43; 35; 17; 17; 132; 58; 28; 3; 72)
		//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
		
		
		REDUCE SELECTION:C351([PO:39]; 0)
		REDUCE SELECTION:C351([POLine:40]; 0)
		vMod:=False:C215
		bRecByChang:=1
		booAccept:=True:C214
		vLineMod:=False:C215
		vMod:=False:C215  //control saving of changes
		haveReceiptID:=True:C214
		
	Else 
		If (booDuringDo)
			If (ptCurTable#(->[Control:1]))
				jsetDuringIncl(->[Control:1])
				SET WINDOW TITLE:C213("Receiving")
				bRecByChang:=1
			End if 
			booAccept:=True:C214
			curLines:=Size of array:C274(aPOLineAction)
			C_LONGINT:C283($cntSelected)
			$cntSelected:=Size of array:C274(aPoLnSelct)
			If ((vLineMod) & (curLines>0) & ($cntSelected>0))
				curLines:=Size of array:C274(aPOLineAction)
				PoLnExtend(aPOLineAction)
				//  CHOPPED  AL_GetScroll(ePoLines; viALVert; viALHorz)
				viVert:=aPOLineAction  //save value of array index setarealine changes it
				//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
				
				//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
				// -- AL_SetSelect(ePoLines; aPoLnSelct)
				viALVert:=aPoLnSelct{1}
				// -- AL_SetScroll(ePoLines; viALVert; viALHorz)
				vMod:=calcPO(True:C214)
				Ray_VarLoadRay(aPORecs; ->aPOTotal; ->[PO:39]total:24; ->aPOOpenAmt; ->[PO:39]amountBackLog:25)
				//  CHOPPED  viALVert:=AL_GetLine(ePOs)
				//  --  CHOPPED  AL_UpdateArrays(ePOs; -2)
				// -- AL_SetLine(ePOs; viALVert)
				viAHorz:=1
				// -- AL_SetScroll(ePOs; viALVert; viAHorz)
				vMod:=True:C214
			End if 
			$doSort:=False:C215
		Else 
			booDuringDo:=True:C214
		End if 
		
End case 