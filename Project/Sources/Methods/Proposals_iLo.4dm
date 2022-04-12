//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-09T00:00:00, 00:16:40
// ----------------------------------------------------
// Method: Proposals_iLo
// Description
// Modified: 08/09/13
// 
// 
//
// Parameters
// ----------------------------------------------------


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/18/10, 16:46:14
// ----------------------------------------------------
// Method: Form Method: [Proposal]iProposals_9
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
$doMore:=False:C215
Case of 
	: ($formEvent=On Close Box:K2:21)  // ### jwm ### 20190307_1913
		jCancelButton
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	: (Outside call:C328)
		If (<>vlRecNum>0)
			Prs_OutsideCall
			FORM NEXT PAGE:C248
			FORM PREVIOUS PAGE:C249
		Else 
			OutSide_Do
		End if 
	: ($formEvent=On Deactivate:K2:10)
		<>vPricePoint:=[Proposal:42]typeSale:20
	Else 
		If ($formEvent=On Load:K2:1)
			FormSizeAuto
			// ### bj ### 20200623_1019 is opening to other than page one. 
			// This is interesting, but not consistent in the program for iLo
			C_LONGINT:C283($viPageOpen)
			$viPageOpen:=FORM Get current page:C276
			If ($viPageOpen#1)
				FORM GOTO PAGE:C247(1)
			End if 
			$doPreNext:=booPreNext
			jsetBefore(->[Proposal:42])
			// TRACE
			PpLineALDefine(ePropList)
			TallyMasterPopupScirpts(->[Proposal:42])
			
			
			
			//  --  CHOPPED  AL_UpdateArrays(eItemPp; -2)
			
			ARRAY TEXT:C222(aPriceForecastOptions; 4)
			aPriceForecastOptions{1}:="Lowest Cost"
			aPriceForecastOptions{2}:="Last/Matrix"
			aPriceForecastOptions{3}:="Matrix"
			aPriceForecastOptions{4}:="Test"
			aPriceForecastOptions:=1
			vrTooling:=0
			//aLineCnts{1}:=viPrplLnCnt
			If (allowAlerts_boo)
				If ($doPreNext)
					$doPreNext:=False:C215
					// -- AL_SetSort(ePropList; 11)
					//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
				End if 
				
			End if 
			srPp:=[Proposal:42]idNum:5
			QQSetColor(eItemPp; ->aLsItemNum)  //###_jwm_### 20101115
			QQSetColor(ePropList; ->aPItemNum)  //###_jwm_### 20101112
			
			$doMore:=True:C214
		End if 
		If (ptCurTable#(->[Proposal:42]))
			$doMore:=True:C214
			changeRecord:=0
			//QA_LoDuringReturn(eAnsListPp;(->[Proposal]);ptCurTable)
			//  CHOPPED QA_LoOnEntry(eAnsListPp; Table(->[Proposal]); [Proposal]customerID; [Proposal]idNum; [Proposal]idNumTask)
			jsetDuringIncl(->[Proposal:42])
			//  --  CHOPPED  AL_UpdateArrays(eItemPp; -2)
		End if 
		If (($doMore) | (changeRecord#0))
			$doMore:=False:C215
			changeRecord:=0
			NxPvProposals
			
			
			CLEAR VARIABLE:C89(vItemPict)
			LBDocument_ent:=ds:C1482.Document.query("idNumTask = :1"; [Proposal:42]idNumTask:70)
			
			ItemSetButtons((Size of array:C274(aPLineAction)>0); True:C214)
			$error:=Exch_GetCurr([Proposal:42]currency:55)  //sets viExConPrec, viExDisPrec
			HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
			Ord_Comment(0)
			
			If ([Proposal:42]idNumTask:70>0)
				QUERY:C277([Document:100]; [Document:100]idNumTask:21=[Proposal:42]idNumTask:70)
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=[Proposal:42]idNumTask:70)
			Else 
				REDUCE SELECTION:C351([WorkOrder:66]; 0)
				REDUCE SELECTION:C351([Document:100]; 0)
			End if 
			WO_FillArrays(Records in selection:C76([WorkOrder:66]))
			If (ePPWos>0)
				//  --  CHOPPED  AL_UpdateArrays(ePPWos; -2)
			End if 
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
			PpLnFillRays(Records in selection:C76([ProposalLine:43]))
			If (ePropList>0)
				//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
			End if 
			//If (aLineCnts{1}>viPrplLnCnt)
			//viPrplLnCnt:=aLineCnts{1}
			//End if 
			srPp:=[Proposal:42]idNum:5
			Before_New(ptCurTable)
		End if 
		If (Locked:C147([Proposal:42]))
			_O_OBJECT SET COLOR:C271(srCustomer; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srAcct; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srZip; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srPhone; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srPp; -(Yellow:K11:2+(256*Red:K11:4)))
		End if 
		
		C_LONGINT:C283($i; $k; $incLine)
		C_REAL:C285($amtTotal)
		MESSAGES OFF:C175
		booAccept:=True:C214
		If (doItemList)
			//  --  CHOPPED  AL_UpdateArrays(eItemPp; -2)
			QQSetColor(eItemPp; ->aLsItemNum)  //###_jwm_### 20101115
			doItemList:=False:C215
		End if 
		
		//aLineCnts{1}:=viPrplLnCnt
		If (aPages#FORM Get current page:C276)  //changing layout  pages
			If (aPages>1)  //change to case statement if multiple AreaList on multiple pages
				// -- AL_SetScroll(ePropList; 0; 0)  //deactivate scroll bars of external area
			Else 
				// -- AL_SetScroll(ePropList; 1; 1)  //deactivate scroll bars of external area
			End if 
		End if 
		If (FORM Get current page:C276=1)  //something happened while on page 1
			If (doSearch>0)
				ListManageSr(eItemPp)
			End if 
			If (vLineMod)
				curLines:=Size of array:C274(aPLineAction)
				PpLnExtend(aPLineAction)
				Calc_Totals(->[Proposal:42]amount:26; ->[Proposal:42]weightEstimate:45; ->curLines; ->viBoxCnt; ->aPExtPrice; ->aPUnitWt; ->aPQtyOrder)
				If ([Proposal:42]customerID:1#"")
					RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; [Proposal:42]amount:26; [Proposal:42]customerID:1)
				End if 
				//  CHOPPED  AL_GetScroll(ePropList; viVert; viHorz)
				viVert:=aPLineAction
				//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
				ARRAY LONGINT:C221(aPPLnSelect; 1)
				aPPLnSelect{1}:=aPLineAction
				// -- AL_SetSelect(ePropList; aPPLnSelect)
				// -- AL_SetScroll(ePropList; viVert; viHorz)
				GOTO OBJECT:C206(pQtyOrd)
				//        // -- AL_SetBackClr (ePropList;
				vLineMod:=False:C215
				vMod:=True:C214  //tests for recalc of total order
				QQSetColor(eItemPp; ->aLsItemNum)  //###_jwm_### 20101115
				QQSetColor(ePropList; ->aPItemNum)  //###_jwm_### 20101112
				// ### bj ### 20210515_2231
				// recalc on line changes
				bCalcNow:=1
			End if 
		End if 
		If (bCalcNow=1)
			C_LONGINT:C283($i; $k)
			vMod:=calcProposal(True:C214)
			If (ePropList>0)
				//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
			End if 
			bCalcNow:=0
			MESSAGES ON:C181
		Else 
			
			//  --  CHOPPED  AL_UpdateArrays(eItemPp; -2)
			//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
			QQSetColor(eItemPp; ->aLsItemNum)  //###_jwm_### 20101115
			QQSetColor(ePropList; ->aPItemNum)  //###_jwm_### 20101112
			booDuringDo:=True:C214
		End if 
End case 