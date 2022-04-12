C_LONGINT:C283($theRec; $error)
//Receiving window -- Script: ePOs
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		//TRACE
		
		ARRAY LONGINT:C221(aPoRcptSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eReceipts; aPoRcptSelect)
		$k:=Size of array:C274(aPoRcptSelect)
		If ($k>0)
			$listNextPO:=True:C214
			If (vMod)
				CONFIRM:C162("Ignor existing entries?")
				$listNextPO:=(OK=1)
			End if 
			If ($listNextPO)
				// CREATE EMPTY SET([PO];"Current")
				//For ($i;1;$k)
				QUERY:C277([PO:39]; [PO:39]idNum:5=aPoRcptPONum{aPoRcptSelect{1}})
				//ADD TO SET("Current")
				// End for 
				//USE SET("Current")
				//CLEAR SET("Current")
				PoArrayManage(-5)
				//
				If (Size of array:C274(aPORecs)=1)
					QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=aPoRcptPONum{aPoRcptSelect{1}})
				Else 
					REDUCE SELECTION:C351([POLine:40]; 0)
				End if 
				PoLnFillRays(Records in selection:C76([POLine:40]))
				//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
				//
				
				QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=aPoRcptID{aPoRcptSelect{1}})
				//
				vsVendorPacking:=aPoRcptPackID{aPoRcptSelect{1}}
				vdVendorPackDate:=aPoRcptPackDate{aPoRcptSelect{1}}
				vsVendorInvoiceNum:=aPoRcptInvNum{aPoRcptSelect{1}}
				vdVendorInvoiceDate:=aPoRcptInvDate{aPoRcptSelect{1}}
				//
				iLoReal7:=0
				iLoReal8:=0
				iLoReal9:=0
				iLoReal6:=0
				iLoReal5:=0
				iLoReal4:=0
				//
				Try_AdjRayFill(Records in selection:C76([InventoryStack:29]))
				//  --  CHOPPED  AL_UpdateArrays(eShipAdj; -2)
				$k:=Size of array:C274(aStkDocID)
				//TRACE
				For ($i; 1; $k)
					If (aStkItem{$i}="FreightPO")
						iLoReal8:=iLoReal8+aStkOrCost{$i}
					Else 
						iLoReal7:=iLoReal7+(aStkOrCost{$i}*aStkOrQty{$i})
						iLoReal5:=iLoReal4+aStkDuty{$i}
						iLoReal4:=iLoReal4+aStkNonPd{$i}
						iLoReal6:=iLoReal4+aStkVAT{$i}
					End if 
				End for 
				iLoReal9:=iLoReal8+iLoReal7
				iLoReal10:=vrVendorInvoiceAmount-iLoReal9
				iLoReal11:=vrVendorInvoiceFreight-iLoReal8
				//TRACE
				
				aPoRcptValue{aPoRcptSelect{1}}:=iLoReal7+iLoReal8
				If (aPoRcptInvNum{aPoRcptSelect{1}}="")
					aPoRcptInvAmount{aPoRcptSelect{1}}:=vrVendorInvoiceAmount
					aPoRcptInvFrght{aPoRcptSelect{1}}:=vrVendorInvoiceFreight
				End if 
				aPoRcptDuty{aPoRcptSelect{1}}:=iLoReal5
				aPoRcptNonProduct{aPoRcptSelect{1}}:=iLoReal4
				aPoRcptVAT{aPoRcptSelect{1}}:=iLoReal6
				
				PoReceiptFillRay(-5; aPoRcptSelect{1})
				//  --  CHOPPED  AL_UpdateArrays(eReceipts; -2)
				ARRAY LONGINT:C221(aPoRcptSelect; 1)
				// -- AL_SetSelect(eReceipts; aPoRcptSelect)
				viALVert:=aPoRcptSelect{1}
				// -- AL_SetScroll(eReceipts; viALVert; viALHorz)
				
				
			End if 
		End if 
	: (ALProEvt=2)
		TRACE:C157
		//
	: (ALProEvt=-1)
	: (ALProEvt=-2)
		//AL_CmdAll (aPORecs;aRayLines)
End case 
ALProEvt:=0