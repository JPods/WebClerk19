//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-09T00:00:00, 00:11:42
// ----------------------------------------------------
// Method: Invoices_iLo
// Description
// Modified: 08/09/13
// 

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore; $booOK; changeInvLines)
C_LONGINT:C283($formEvent; changeRecord)
C_BOOLEAN:C305($initComplete)
$formEvent:=Form event code:C388
If (vLineMod)
	
	
End if 

If (changeRecord#0)
	
End if 

Case of 
	: ($formEvent=On Close Box:K2:21)  // ### jwm ### 20181211_1052
		jCancelButton
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	: (Outside call:C328)
		Case of 
			: (<>vbDoQuit)
				jAcceptButton(True:C214; True:C214)
			: (<>prsTableNum=-3)
				jCancelButton
			: (<>vlRecNum>0)
				Prs_OutsideCall
				FORM NEXT PAGE:C248
				FORM PREVIOUS PAGE:C249
			Else 
				OutSide_Do
		End case 
		QQSetColor(eItemInv; ->aLsItemNum)  //###_jwm_### 20101115
		QQSetColor(eIvcList; ->aiItemNum)  //###_jwm_### 20101115
		
	: ($formEvent=On Deactivate:K2:10)
		<>vPricePoint:=[Invoice:26]typeSale:49  // for use in the QuickQuote Window on leaving this window
	Else 
		C_LONGINT:C283($formEvent)
		//  should this be added
		If ($formEvent=On Load:K2:1)  // |(srIV#[Invoice]InvoiceNum))
			C_BOOLEAN:C305(vnotLocked; $booOK)
			$booOK:=True:C214
			vnotLocked:=True:C214
			$initComplete:=False:C215
			
			
			If (Is new record:C668([Invoice:26]))
				[Invoice:26]action:112:="Collect from Customer"
				[Invoice:26]actionBy:110:=Current user:C182
				[Invoice:26]actionDate:111:=Current date:C33+3
				[Invoice:26]actionTime:113:=?07:31:00?
				
				[Invoice:26]customerID:3:=[Customer:2]customerID:1  // must be set before relate records
				//[Invoice]OrderNum:=[Order]OrderNum  // must be set before relate records
				If (process_o.tableParent#Null:C1517)
					If (process_o.tableParent="Order")
						vHere:=2
					End if 
				Else 
					If (process_o.parentTable#Null:C1517)
						If (process_o.parentTable="Order")
							vHere:=2
						End if 
					End if 
				End if 
				
				
				If (vHere>1)  //coming from another table's input layout do this before iLoProcedure
					$ptLastTable:=ptCurTable
					$fillFromPrevious:=True:C214
					// Modified by: Bill James (2017-12-13T00:00:00) The invoice and invoice Order num need
					// to be fixed before relating records
					$booOK:=NxPvInvAccess
					iLoRecordChange:=False:C215
					$initComplete:=True:C214
					
				End if 
				
			End if 
			
			$formEvent:=iLoProcedure(->[Invoice:26])
			
		End if 
		//
		
		//C_LONGINT($formEvent)
		//$formEvent:=iLoProcedure (->[Invoice])
		//
		If (changeRecord#0)
			changeRecord:=0  // flag also cleared in Before_New
			iLoRecordNew:=Is new record:C668([Invoice:26])
			iLoRecordChange:=True:C214
		End if 
		$doMore:=False:C215
		Case of 
			: ($initComplete=True:C214)
				$doMore:=True:C214
			: (iLoRecordNew)  //set in iLoProcedure only once
				// Modified by: Bill James (2017-12-13T00:00:00) The invoice and invoice Order num need
				// to be fixed before relating records
				// will this ever be called ????
				$booOK:=NxPvInvAccess
				If ($booOK)
					$doMore:=True:C214
				Else 
					$doMore:=False:C215
					CANCEL:C270
				End if 
			: (iLoRecordChange)  //set in iLoProcedure only once
				$booOK:=NxPvInvAccess
				If ($booOK)
					$doMore:=True:C214
				Else 
					$doMore:=False:C215
					CANCEL:C270
				End if 
		End case 
		If ($doMore)
			LBDocument_ent:=ds:C1482.Document.query("idNumTask = :1"; [Invoice:26]idNumTask:78)
			CLEAR VARIABLE:C89(vItemPict)
			
			C_BOOLEAN:C305($booOK)
			C_REAL:C285($discntPrc)
			iLoRecordNew:=False:C215
			iLoRecordChange:=False:C215
			$doPreNext:=booPreNext
			
			//aLineCnts{3}:=viInvcLnCnt
			//jsetBefore (->[Invoice])
			jNxPvButtonSet
			NxPvInvoices
			If ($doPreNext)  //why is this here????  
				$doPreNext:=False:C215
				// -- AL_SetSort(eIvcList; 12)
				//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)
			End if 
			$doMore:=False:C215
			
			sAltAcct:=""  //make sure this is empty
			ARRAY LONGINT:C221(aSrlChngRec; 0)
			MESSAGES ON:C181
			srIv:=[Invoice:26]idNum:2
			
			
			Case of 
				: (Not:C34(Is new record:C668([Invoice:26])))
					HIGHLIGHT TEXT:C210(pPartNum; 1; 36)
				: (<>tcDefaultSelectInvField=<>ciSelectInvField_PN)
					HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
				: (<>tcDefaultSelectInvField=<>ciSelectInvField_Cust)
					HIGHLIGHT TEXT:C210(srCustomer; 1; 40)
				: (<>tcDefaultSelectInvField=<>ciSelectInvField_Name)
					HIGHLIGHT TEXT:C210([Customer:2]nameLast:23; 1; 40)
				: (<>tcDefaultSelectInvField=<>ciSelectInvField_Phone)
					HIGHLIGHT TEXT:C210(srPhone; 1; 40)
				: (<>tcDefaultSelectInvField=<>ciSelectInvField_Zip)
					HIGHLIGHT TEXT:C210(srZip; 1; 35)
				: (<>tcDefaultSelectInvField=<>ciSelectInvField_Acct)
					HIGHLIGHT TEXT:C210(srAcct; 1; 35)
			End case 
			//Set [Invoice]UPSBillingOption default to "Prepaid & Add"
			If ([Invoice:26]upsBillingOption:81="")
				[Invoice:26]upsBillingOption:81:="Prepaid & Add"
			End if 
			//
			TallyMasterPopupScirpts(process_o.dataClassPtr)
			$okToSave:=OrderInvoiceLineMisMatch
			
			QQSetColor(eItemInv; ->aLsItemNum)  //###_jwm_### 20101115
			QQSetColor(eIvcList; ->aiItemNum)  //###_jwm_### 20101115
			
			Before_New(process_o.dataClassPtr)  //last thing to do Clear iLoRecordChange
			
		End if 
		//every cycle
		
		
		MESSAGES OFF:C175
		//set wt check box to enterable only for "Prepaid & Add" bill to option
		If ([Invoice:26]upsBillingOption:81="Prepaid@")
			OBJECT SET ENTERABLE:C238([Invoice:26]shipAuto:32; True:C214)
		Else 
			[Invoice:26]shipAuto:32:=False:C215
			OBJECT SET ENTERABLE:C238([Invoice:26]shipAuto:32; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]shipMiscCosts:16; Not:C34([Invoice:26]shipAuto:32))
			OBJECT SET ENTERABLE:C238([Invoice:26]shipFreightCost:15; Not:C34([Invoice:26]shipAuto:32))
		End if 
		
		If (([Invoice:26]consignment:63="") | ([Invoice:26]consignment:63="Complete@"))
			OBJECT SET RGB COLORS:C628(*; "[Invoice:26]consignment:63"; Black:K11:16; 256*White:K11:1)
		Else 
			OBJECT SET RGB COLORS:C628(*; "[Invoice:26]consignment:63"; Black:K11:16; 256*Yellow:K11:2)  //SET COLOR (bInfo;  (vForeground + (256 * vBackground)))
		End if 
		
		
		If (Locked:C147([Invoice:26]))
			OBJECT SET RGB COLORS:C628(*; "srCustomer"; Yellow:K11:2; 256*Red:K11:4)
			OBJECT SET RGB COLORS:C628(*; "srAcct"; Yellow:K11:2; 256*Red:K11:4)
			OBJECT SET RGB COLORS:C628(*; "srZip"; Yellow:K11:2; 256*Red:K11:4)
			OBJECT SET RGB COLORS:C628(*; "srPhone"; Yellow:K11:2; 256*Red:K11:4)
			OBJECT SET RGB COLORS:C628(*; "srIv"; Yellow:K11:2; 256*Red:K11:4)
		End if 
		
		$vMod:=False:C215
		If (doItemList)
			//  --  CHOPPED  AL_UpdateArrays(eItemInv; -2)
			QQSetColor(eIvcList; ->aiItemNum)  //###_jwm_### 20101115
			QQSetColor(eItemInv; ->aLsItemNum)  //###_jwm_### 20101115
			doItemList:=False:C215
		End if 
		If (ptCurTable#(->[Invoice:26]))
			//QA_LoDuringReturn(eAnsListInvoices;(->[Invoice]);ptCurTable)
			//  CHOPPED QA_LoOnEntry(eAnsListInvoices; Table(->[Invoice]); [Invoice]customerID; [Invoice]idNum; [Invoice]idNumTask)
			jsetDuringIncl(->[Invoice:26])
			ItemSetButtons((Size of array:C274(aiLineAction)>0); Not:C34(([Invoice:26]jrnlComplete:48=True:C214) | (changeInv=False:C215)))
			
			$error:=Exch_GetCurr([Invoice:26]currency:62)  //sets viExConPrec, viExDisPrec
			Ord_Comment(0)
			HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
			//If (aLineCnts{3}>viInvcLnCnt)
			//viInvcLnCnt:=aLineCnts{3}
			//End if 
			srIv:=[Invoice:26]idNum:2
		End if 
		//aLineCnts{3}:=viInvcLnCnt
		If ((aPages#FORM Get current page:C276) | (vbNxPvPage))  //changing layout  pages
			vbNxPvPage:=False:C215  //use to adj to menu changes in pages                
			Case of 
				: (aPages=1)
					// -- AL_SetScroll(eIvcList; 1; 1)
					// -- AL_SetScroll(eItemInv; 1; 1)
					// -- AL_SetScroll(eProfileIv; 0; 0)
					// -- AL_SetScroll(eAnsListInvoices; 0; 0)
					//// -- AL_SetScroll (eLoadTagsInvoices;0;0)
					//// -- AL_SetScroll (eLoadItemsOrders;0;0)
					
				: (aPages=2)
					// -- AL_SetScroll(eIvcList; 0; 0)
					// -- AL_SetScroll(eItemInv; 0; 0)
					// -- AL_SetScroll(eProfileIv; 0; 0)
					// -- AL_SetScroll(eAnsListInvoices; 0; 0)
					//// -- AL_SetScroll (eLoadTagsInvoices;0;0)
					//// -- AL_SetScroll (eLoadItemsOrders;0;0)
				: (aPages=3)
					// -- AL_SetScroll(eIvcList; 0; 0)
					// -- AL_SetScroll(eItemInv; 0; 0)
					// -- AL_SetScroll(eProfileIv; 1; 1)
					// -- AL_SetScroll(eAnsListInvoices; 0; 0)
					//// -- AL_SetScroll (eLoadTagsInvoices;0;0)
					//// -- AL_SetScroll (eLoadItemsOrders;0;0)
					
				: (aPages=4)
					// -- AL_SetScroll(eIvcList; 0; 0)
					// -- AL_SetScroll(eItemInv; 0; 0)
					// -- AL_SetScroll(eProfileIv; 0; 0)
					// -- AL_SetScroll(eAnsListInvoices; 1; 1)
					//// -- AL_SetScroll (eLoadTagsInvoices;0;0)
					//// -- AL_SetScroll (eLoadItemsOrders;0;0)
					
				: (aPages=5)
					// -- AL_SetScroll(eIvcList; 0; 0)
					// -- AL_SetScroll(eItemInv; 0; 0)
					// -- AL_SetScroll(eProfileIv; 0; 0)
					// -- AL_SetScroll(eAnsListInvoices; 0; 0)
					//// -- AL_SetScroll (eLoadTagsInvoices;1;1)
					//// -- AL_SetScroll (eLoadItemsInvoices;1;1)
			End case 
		End if 
		curLines:=Size of array:C274(aiLineAction)
		If (FORM Get current page:C276=1)  //something happened while on page 1
			If (doSearch=888)
				If (vLineMod)
					IvcLnExtend(aiLineAction)
				End if 
				acceptInvoice
				doSearch:=0
			End if 
			If (doSearch>0)
				ListManageSr(eItemInv)
			End if   //
			//             
			If (vLineMod)
				IvcLnExtend(aiLineAction)
				//Calc_Totals (->[Invoice]Amount;->[Invoice]WeightEstimate;->curLines;->viBoxCnt;->aiExtPrice;->aiExtWt;->aiQtyShip)
				If (([Invoice:26]customerID:3#"") & ([Invoice:26]idNumOrder:1=1))
					RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; [Invoice:26]amount:14-vrOldValue; [Invoice:26]customerID:3)
				End if 
				//
				//  CHOPPED  AL_GetScroll(eIvcList; viVert; viHorz)
				viVert:=aiLineAction
				//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)
				ARRAY LONGINT:C221(aRayLines; 1)
				aRayLines{1}:=aiLineAction
				// -- AL_SetSelect(eIvcList; aRayLines)
				// -- AL_SetScroll(eIvcList; viVert; viHorz)
				QQSetColor(eIvcList; ->aiItemNum)  //###_jwm_### 20101115
				QQSetColor(eItemInv; ->aLsItemNum)  //###_jwm_### 20101115
				//
				vLineMod:=False:C215
				vMod:=True:C214  //tests for recalc of total order    
				
				// ### bj ### 20210515_2250
				// calculate every line change
				bCalcNow:=1
			End if 
			If (bCalcNow=1)
				If ([Invoice:26]dateLinked:31=!00-00-00!)
					vMod:=calcInvoice(True:C214)
				Else 
					jAlertMessage(10007)
				End if 
				bCalcNow:=0
			End if 
			If (FORM Get current page:C276=1)
				$cntRay:=Size of array:C274(aiLineAction)
				C_REAL:C285($amount; $itemCnt)
				For ($incRay; 1; $cntRay)
					$amount:=$amount+aiExtPrice{$incRay}
					$itemCnt:=$itemCnt+aiQtyShip{$incRay}
				End for 
				[Invoice:26]amount:14:=Round:C94($amount; <>tcDecimalTt)
				viBoxCnt:=$itemCnt
				viInvcLnCnt:=$cntRay
			End if 
			MESSAGES ON:C181
		Else 
			//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)
			//  --  CHOPPED  AL_UpdateArrays(eItemInv; -2)
			//  --  CHOPPED  AL_UpdateArrays(eProfileIv; -2)
			QQSetColor(eIvcList; ->aiItemNum)  //###_jwm_### 20101115
			QQSetColor(eItemInv; ->aLsItemNum)  //###_jwm_### 20101115      
			booDuringDo:=True:C214
		End if 
		
		booAccept:=(([Invoice:26]customerID:3#"") & ([Invoice:26]idNum:2#0))
End case 
