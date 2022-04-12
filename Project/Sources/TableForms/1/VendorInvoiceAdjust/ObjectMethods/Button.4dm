C_LONGINT:C283($theRec; $error)
//Receiving window -- Script: ePOs
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		//TRACE
		$listNextPO:=True:C214
		If (vMod)
			//Ray_VarLoadRay (aPORecs;aPOTotal;[PO]Total;aPOOpenAmt;[POs
			//]OpenPOAmount)
			CONFIRM:C162("Ignor existing entries?")
			$listNextPO:=(OK=1)
		End if 
		If ($listNextPO)
			C_LONGINT:C283($curPO)
			$curPO:=[PO:39]idNum:5
			//  CHOPPED  aPORecs:=AL_GetLine(ePOs)
			GOTO RECORD:C242([PO:39]; aPORecs{aPORecs})
			LOAD RECORD:C52([PO:39])
			If ([PO:39]idNum:5#$curPO)
				vlReceiptID:=0
				vsVendorPacking:=""
				vsVendorInvoiceNum:=""
				vrVendorInvoiceFreight:=0
				vR1:=0
				vR2:=0
				vR3:=3
			End if 
			If (Not:C34(Locked:C147([PO:39])))
				QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
				PoLnFillRays(Records in selection:C76([POLine:40]))
				//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
				//
				//TRACE
				QUERY:C277([POReceipt:95]; [POReceipt:95]idNumPO:2=[PO:39]idNum:5)
				PoReceiptFillRay(Records in selection:C76([POReceipt:95]))
				//  --  CHOPPED  AL_UpdateArrays(eReceipts; -2)
				//
				QUERY:C277([InventoryStack:29]; [InventoryStack:29]docid:5=[PO:39]idNum:5)
				Try_AdjRayFill(Records in selection:C76([InventoryStack:29]))
				//  --  CHOPPED  AL_UpdateArrays(eShipAdj; -2)
				QUERY:C277([InventoryStack:29]; [InventoryStack:29]docid:5=[PO:39]idNum:5)
				Try_AdjRayFill(Records in selection:C76([InventoryStack:29]))
				
			Else 
				jAlertMessage(10004)
			End if 
			PoLnFillVar(0)
		Else 
			C_LONGINT:C283($w)
			$w:=Find in array:C230(aPOs; [PO:39]idNum:5)
			If ($w>0)
				//  --  CHOPPED  AL_UpdateArrays(ePOs; -2)
				// -- AL_SetLine(ePOs; $w)
				viVert:=$w
				// -- AL_SetScroll(ePOs; viVert; viHorz)
			End if 
		End if 
		
	: (ALProEvt=2)
		If (vMod)
			TRACE:C157
			acceptPO
		End if 
		//  CHOPPED  aPORecs:=AL_GetLine(ePOs)
		GOTO RECORD:C242([PO:39]; aPORecs{aPORecs})
		REDUCE SELECTION:C351([POLine:40]; 0)
		//MODIFY RECORD([PO])
		If (myOK=1)
			Ray_VarLoadRay(aPORecs; ->aPOStatus; ->[PO:39]buyer:7; ->aPOs; ->[PO:39]idNum:5; ->aVendors; ->[PO:39]vendorCompany:39; ->aPODate; ->[PO:39]dateNeeded:3; ->aPOTotal; ->[PO:39]total:24; ->aPOOpenAmt; ->[PO:39]amountBackLog:25; ->aPOAttn; ->[PO:39]attention:26)
			doSearch:=7
		End if 
		//LOAD RECORD([PO])
		//If (Not(Locked([PO])))
		//QUERY([POLine];[POLine]PONum=[PO]PONum)
		PoLnFillRays(Records in selection:C76([POLine:40]))
		//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
		//Else 
		//jAlertMessage (10004)
		//End if 
		ProcessTableOpen(Table:C252(->[PO:39])*-1)
		TRACE:C157
		//
	: (ALProEvt=-1)
	: (ALProEvt=-2)
		//AL_CmdAll (aPORecs;aRayLines)
End case 
ALProEvt:=0