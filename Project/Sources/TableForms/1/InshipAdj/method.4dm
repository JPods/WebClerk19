Case of 
	: (Outside call:C328)
		Prs_OutsideCall
	: ((Before:C29) | (booPreNext))
		C_LONGINT:C283($k; $i; $gotoLine)
		C_BOOLEAN:C305($doSort; vLineMod)
		C_LONGINT:C283(srPO)
		
		viRecordsInSelection:=0
		ARRAY LONGINT:C221(aRayLines; 0)
		bNewRec:=0
		TRACE:C157
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Inship Adjustments")
		doSearch:=0
		If (myOK=12)
			QUERY:C277([InventoryStack:29]; [InventoryStack:29]docid:5=[PO:39]idNum:5)
			Try_AdjRayFill(Records in selection:C76([InventoryStack:29]))
		Else 
			Try_AdjRayFill(0)
		End if 
		myOK:=0
		Try_AdjALDefine(eShipAdj)
		vMod:=False:C215
		bRecByChang:=1
		b42:=1
		b41:=0
	Else 
		If (booDuringDo)
			If (ptCurTable#(->[Control:1]))
				jsetDuringIncl(->[Control:1])
				SET WINDOW TITLE:C213("Inship Adjustments")
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
						doQuickQuote:=1
						
						QueryEditorModal(->[InventoryStack:29])
						
						doQuickQuote:=0
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
		Else 
			booDuringDo:=True:C214
		End if 
		
End case 
