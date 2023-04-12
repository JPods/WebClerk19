//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-09T00:00:00, 00:15:49
// ----------------------------------------------------
// Method: Orders_iLo
// Description
// Modified: 08/09/13
// 
// 
//
// Parameters
// ----------------------------------------------------

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/10/09, 16:21:23
// ----------------------------------------------------
// Method: Form Method: iOrders_9
// Description
// 
//
// Parameters
// ----------------------------------------------------


KeyModifierCurrent
If ((OptKey=1) & (CmdKey=1))
	
End if 

C_LONGINT:C283($formEvent)
C_LONGINT:C283(srSO)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Close Box:K2:21)  // ### jwm ### 20181211_1052
		jCancelButton
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	: ($formEvent=On Deactivate:K2:10)
		<>vPricePoint:=[Order:3]typeSale:22
	: ($formEvent=On Outside Call:K2:11)  //: (Outside call)
		C_LONGINT:C283(<>prsTableNum)
		Case of 
			: (<>prsTableNum=-3)
				jCancelButton
				
			: (<>vlRecNum>0)
				Prs_OutsideCall
			: (<>vbDoQuit)
				jAcceptButton(True:C214; True:C214)
			Else 
				OutSide_Do
		End case 
		QQSetColor(eItemOrd; ->aLsItemNum)  //###_jwm_### 20101112
		QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101112
		
	: ($formEvent=On Activate:K2:9)  // ### jwm ### 20170707_2103 when becomes front window
		jsetBefore(->[Order:3])
		//TRACE  // check this
		
	: (Form event code:C388=On Timer:K2:25)
		If (Macintosh option down:C545)
			OBJECT SET TITLE:C194(*; "bQQPull"; "QQPush")
		Else 
			OBJECT SET TITLE:C194(*; "bQQPull"; "QQPull")
		End if 
		
	Else 
		If (($formEvent=On Load:K2:1) | (booPreNext) | (srSO#[Order:3]idNum:2))  //Before
			
			// entry_o:=process_o.cur
			SET TIMER:C645(20)
			
			FormSizeAuto
			
			C_REAL:C285(vrAmountOverRide)
			//REDUCE SELECTION([LoadTag];0)
			//REDUCE SELECTION([LoadItem];0)
			////  CHOPPED  AL_UpdateFields (eLoadTagsOrders;2)
			////  CHOPPED  AL_UpdateFields (eLoadItemsOrders;2)
			MESSAGES OFF:C175
			jsetBefore(->[Order:3])
			$doPreNext:=booPreNext
			booPreNext:=False:C215
			OrdLineALDefine(eOrdList)
			OrdLineALDefine(eOrdLn2POs)
			
			If (False:C215)
				// ### jwm ### 20150914_1734 transactions test
				
				If ([Order:3]idNum:2>0)
					TransactionStart(->[Order:3])  // ### jwm ### 20150911_1655
				End if 
				
			End if 
			
			NxPvOrders
			$okToSave:=OrderInvoiceLineMisMatch
			srSO:=[Order:3]idNum:2
			
			ARRAY TEXT:C222(aOSOrdProcess; 0)
			ARRAY LONGINT:C221(aOSOrdProcessRec; 0)
			//
			TallyMasterPopupScirpts(->[Order:3])
			//Set [Invoice]UPSBillingOption default to "Prepaid & Add"
			If ([Order:3]upsBillingOption:89="")
				[Order:3]upsBillingOption:89:="Prepaid & Add"
			End if 
			If (([Order:3]dateReceived:125=!00-00-00!) & (Is new record:C668([Order:3])))
				[Order:3]dateReceived:125:=Current date:C33
			End if 
			//If ($formEvent=On Load)
			//If (eOrdList#0)//why is this here?
			//// -- AL_SetSort (eOrdList;13)
			//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
			//  --  CHOPPED  AL_UpdateArrays(eItemOrd; -2)
			////  --  CHOPPED  AL_UpdateArrays (eProfilesOrder;-2)
			//  --  CHOPPED  AL_UpdateArrays(eProfilesOrder; -2)
			//  --  CHOPPED  AL_UpdateArrays(eOrdLn2POs; -2)
			//  --  CHOPPED  AL_UpdateArrays(eOrdMatlDrw; -2)
			//  --  CHOPPED  AL_UpdateArrays(eOrdTime; -2)
			//  --  CHOPPED  AL_UpdateArrays(eOrdWos; -2)
			//  --  CHOPPED  AL_UpdateArrays(eOrdLnCost; -2)
			//  --  CHOPPED  AL_UpdateArrays(eAnsListOrders; -2)
			If ($formEvent=On Load:K2:1)
				// -- AL_SetScroll(eOrdList; 1; 1)
				// -- AL_SetScroll(eItemOrd; 1; 1)
				//// -- AL_SetScroll (eProfilesOrder;0;0)
				// -- AL_SetScroll(eProfilesOrder; 0; 0)
				// -- AL_SetScroll(eOrdLn2POs; 0; 0)
				// -- AL_SetScroll(eOrdMatlDrw; 0; 0)
				// -- AL_SetScroll(eOrdTime; 0; 0)
				// -- AL_SetScroll(eOrdWos; 0; 0)
				// -- AL_SetScroll(eOrdLnCost; 0; 0)
				// -- AL_SetScroll(eAnsListOrders; 0; 0)
				//// -- AL_SetScroll (eLoadTagsOrders;0;0)
				//// -- AL_SetScroll (eLoadItemsOrders;0;0)
				Profiles_Relate(eProfilesOrder)
			End if 
			
			QQSetColor(eItemOrd; ->aLsItemNum)  //###_jwm_### 20101112
			QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101112
			
			Before_New(ptCurTable)
			
		End if 
		ILO_OrderDur
		//set wt check box to enterable only for "Prepaid & Add" bill to option
		If ([Order:3]upsBillingOption:89="Prepaid@")
			OBJECT SET ENTERABLE:C238([Order:3]shipAuto:40; True:C214)
		Else 
			[Order:3]shipAuto:40:=False:C215
			OBJECT SET ENTERABLE:C238([Order:3]shipAuto:40; False:C215)
			OBJECT SET ENTERABLE:C238([Order:3]shipMiscCosts:25; Not:C34([Order:3]shipAuto:40))
			OBJECT SET ENTERABLE:C238([Order:3]shipFreightCost:38; Not:C34([Order:3]shipAuto:40))
		End if 
		
End case 

