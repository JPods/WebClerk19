Case of 
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
		vsVendorPacking:=""
		vsVendorInvoiceNum:=""
		vdVendorInvoiceDate:=Current date:C33
		vdVendorPackDate:=Current date:C33
		vrVendorInvoiceFreight:=0
		vrVendorInvoiceAmount:=0
		b31:=1  //New ReceiptID every Save
		vlReceiptID:=-1
		iLoReal1:=0
		iLoReal2:=0
		iLoReal3:=0
		iLoReal4:=0
		iLoReal10:=0
		vsiteID:=DSGetMachineSiteID
		// TRACE
		PoLnFillRays(0)
		REDUCE SELECTION:C351([PO:39]; 0)
		PoArrayManage(-5)
		POALDefine
		// -- AL_SetRowOpts(ePOs; 0; 0; 0; 0; 1)  //reset this item.
		//  CHOPPED  POLineALDefine(ePoLines)
		
		// -- AL_SetHdrStyle(ePoLines; 1; "Geneva"; 9; 2)  //Item Number
		// -- AL_SetWidths(ePoLines; 1; 12; 80; 3; 43; 43; 35; 17; 17; 380; 58; 28; 3; 72)
		//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
		//
		Try_AdjRayFill(0)
		Try_AdjALDefine(eShipAdj)
		//
		PoReceiptFillRay(0)
		PoReceiptALDefine(eReceipts)
		
		
		REDUCE SELECTION:C351([PO:39]; 0)
		REDUCE SELECTION:C351([POLine:40]; 0)
		vMod:=False:C215
		bRecByChang:=1
		booAccept:=True:C214
		vLineMod:=False:C215
		vMod:=False:C215  //control saving of changes
		haveReceiptID:=True:C214
		
		
	: (Outside call:C328)
		Prs_OutsideCall
		
	Else 
		If (booDuringDo)
			If (ptCurTable#(->[Control:1]))
				jsetDuringIncl(->[Control:1])
				SET WINDOW TITLE:C213("Receiving")
				bRecByChang:=1
			End if 
			
			
			If (doSearch>0)
				Case of 
					: (doSearch=200)
						$k:=Size of array:C274(aStkSelect)
						//  If (b41=1)
						vR1:=0
						For ($i; 1; $k)
							If (aStkSelect{$i}<=Size of array:C274(aStkDuty))
								vR1:=vR1+aStkDuty{aStkSelect{$i}}
							End if 
						End for 
						//  End if 
						// If (b42=1)
						vR2:=0
						For ($i; 1; $k)
							If (aStkSelect{$i}<=Size of array:C274(aStkNonPd))
								vR2:=vR2+aStkNonPd{aStkSelect{$i}}
							End if 
						End for 
						//  End if 
						//   If (b43=1)
						vR3:=0
						For ($i; 1; $k)
							If (aStkSelect{$i}<=Size of array:C274(aStkNonPd))
								vR3:=vR3+aStkNonPd{aStkSelect{$i}}
							End if 
						End for 
						// End if 
					: (doSearch=4)
						MESSAGES OFF:C175
						KeyModifierCurrent
						Srch_FullDia(->[InventoryStack:29])
						MESSAGES ON:C181
					: (doSearch=5)
						MESSAGES OFF:C175
						QUERY:C277([InventoryStack:29]; [InventoryStack:29]docid:5=srPO)
						MESSAGES ON:C181
					: (doSearch=7)
						MESSAGES OFF:C175
						QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=srPO)
						MESSAGES ON:C181
						//:(doSearch=12)      Save, update only
					: ((doSearch=8) & (doSearch<10))  //split by cost
						
					: ((doSearch=9) & (doSearch<11))  //split by cost
						
				End case 
				$doReset:=False:C215
				If (doSearch<8)
					Try_AdjRayFill(Records in selection:C76([InventoryStack:29]))
				Else 
					//  CHOPPED  $err:=AL_GetSelect(eShipAdj; aStkSelect)
					//  CHOPPED  AL_GetScroll(eShipAdj; viALVert; viALHorz)
					$doReset:=True:C214
				End if 
				//  --  CHOPPED  AL_UpdateArrays(eShipAdj; -2)
				If ($doReset)
					// -- AL_SetSelect(eShipAdj; aStkSelect)
					// -- AL_SetScroll(eShipAdj; viALVert; viALHorz)
				End if 
			End if 
			doSearch:=0
			$doSort:=False:C215
			
			
			
			
			
			
			
			
			
			booAccept:=True:C214
			curLines:=Size of array:C274(aPOLineAction)
			If ((vLineMod) & (curLines>0))
				curLines:=Size of array:C274(aPOLineAction)
				PoLnExtend(aPOLineAction)
				//  CHOPPED  AL_GetScroll(ePoLines; viALVert; viALHorz)
				viVert:=aPOLineAction  //save value of array index setarealine changes it
				//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
				
				//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
				If (Size of array:C274(aPoLnSelct)>0)
					// -- AL_SetSelect(ePoLines; aPoLnSelct)
					viALVert:=aPoLnSelct{1}
					// -- AL_SetScroll(ePoLines; viALVert; viALHorz)
				End if 
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