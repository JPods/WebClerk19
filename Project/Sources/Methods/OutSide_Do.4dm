//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/18/09, 17:42:23
// ----------------------------------------------------
// Method: OutSide_Do
// Description
// // Modified by: williamjames (10/18/09)   : (ptCurTable=(->[Item]))  //###_jwm_### 20091001

//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20140929_1512 added parameters 10 and 11 to WO_TransferCreate
// ### jwm ### 20150114_1322 changed for to from

C_LONGINT:C283(<>callerIDNum; $myCur)
C_TEXT:C284($1; $vTaskName)
C_TEXT:C284(<>vControlProcess)
If (Count parameters:C259=1)
	$vTaskName:=$1
End if 
$myCur:=<>callerIDNum
<>callerIDNum:=0
C_BOOLEAN:C305(<>bQQAddItems)
C_TEXT:C284(<>vtDescription; <>vtMore)
C_REAL:C285(<>vrPrice; <>vrCost)
Case of 
	: (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
		Quit_Processes
		
	: (ptCurTable=(->[Item:4]))  //###_jwm_### 20091001
		BOM_DoBOM
		
	: ((<>vControlProcess="WorkOrder Transfers") | ($vTaskName="WorkOrder Transfers"))
		C_LONGINT:C283($dtcurrent)
		$dtcurrent:=DateTime_Enter
		CREATE EMPTY SET:C140([WorkOrder:66]; "Current")
		READ ONLY:C145([Employee:19])
		READ ONLY:C145([Item:4])
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=Current user:C182)
		$k:=Size of array:C274(<>aItemLines)
		For ($i; 1; $k)
			GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{$i}})
			// ### jwm ### 20140929_1512 added parameters 10 and 11
			WO_TransferCreate([Item:4]itemNum:1; pQtyOrd; vltaskID; iLoDate1; iLo80String1; iLo80String2; iLo80String3; "RequestedTransfer"; iLo80String4; iLo80String5; vlGroupID)
			
			If (Records in selection:C76([Employee:19])=1)
				[WorkOrder:66]phone:56:=[Employee:19]phone1:13
			End if 
			SAVE RECORD:C53([WorkOrder:66])
			ADD TO SET:C119([WorkOrder:66]; "Current")
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		REDUCE SELECTION:C351([Item:4]; 0)
		REDUCE SELECTION:C351([Employee:19]; 0)
		
	: (<>vControlProcess="expand the number of cases")
		
		
		
	: ((<>bQQAddItems) & (vHere>1))
		$doAdd:=False:C215
		$k:=Size of array:C274(<>aItemLines)
		Case of 
			: (ptCurTable=(->[Item:4]))
				If ([Item:4]bomHasChild:48)
					$doAdd:=True:C214
				Else 
					CONFIRM:C162("Add BOM components to "+[Item:4]itemNum:1)
					$doAdd:=(OK=1)
				End if 
				If ($doAdd)
					[Item:4]bomHasChild:48:=True:C214
					BOM_AddChildren
					BOM_BuildExtend([Item:4]itemNum:1)
					//  --  CHOPPED  AL_UpdateArrays(eBOMList; -2)
				End if 
			: ((ptCurTable=(->[Order:3])) | (ptCurTable=(->[Invoice:26])) | (ptCurTable=(->[PO:39])) | (ptCurTable=(->[Proposal:42])))
				// ### bj ### 20210519_0951
				If ((ptCurTable=(->[Invoice:26])) & ([Invoice:26]dateLinked:31#!00-00-00!))
					ALERT:C41("dateLinked must to 00/00/00 to add Invoice items")
					bCalcNow:=0
				Else 
					If (Size of array:C274(<>aLsSrRec)>0)
						CONFIRM:C162("Pull from QuickQuote Window?")  // ### jwm ### 20150114_1322 changed for to from
						If (OK=1)
							bCalcNow:=1
							For ($i; 1; $k)
								GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{$i}})
								pPartNum:=[Item:4]itemNum:1
								pDescript:=[Item:4]description:7
								pUnitCost:=[Item:4]costAverage:13
								Case of 
									: (ptCurTable=(->[Order:3]))
										//viOrdLnCnt:=viOrdLnCnt+1
										OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
										aOQtyOrder{aoLineAction}:=<>rQQAddQty
										If (<>vtDescription#"")
											aODescpt{aoLineAction}:=<>vtDescription
										End if 
										If (<>vtMore#"")
											aoLnComment{aoLineAction}:=<>vtMore
										End if 
										If (<>vrPrice#0)
											If (<>vrPrice=-0.001)
												<>vrPrice:=0
											End if 
											aOUnitPrice{aoLineAction}:=<>vrPrice
										End if 
										If (<>vrCost#0)
											If (<>vrCost=-0.001)
												<>vrCost:=0
											End if 
											aOUnitCost{aoLineAction}:=<>vrCost
										Else 
											QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="MfrMargin"; *)
											QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=[Item:4]mfrID:53)
											If (Records in selection:C76([TallyMaster:60])=1)
												aOUnitCost{aoLineAction}:=aOUnitPrice{aoLineAction}*Num:C11([TallyMaster:60]realName1:16)
											End if 
											UNLOAD RECORD:C212([TallyMaster:60])
										End if 
										OrdLnExtend(aoLineAction)
										<>vrPrice:=0
										<>vrCost:=0
										<>vtDescription:=""
										<>vtMore:=""
									: (ptCurTable=(->[Invoice:26]))
										//viInvcLnCnt:=viInvcLnCnt+1
										IvcLnAdd((Size of array:C274(aiLineAction)+1); 1; False:C215)
										aiQtyShip{aiLineAction}:=<>rQQAddQty
										pQtyShip:=<>rQQAddQty
										IvcLnExtend(aiLineAction)
										bCalcNow:=1
									: (ptCurTable=(->[PO:39]))
										//viPOLnCnt:=viPOLnCnt+1
										POLnAdd((Size of array:C274(aPOLineAction)+1); 1; False:C215)
										aPOQtyOrder{aPOLineAction}:=<>rQQAddQty
										pQtyShip:=<>rQQAddQty
										PoLnExtend(aPOLineAction)
									: (ptCurTable=(->[Proposal:42]))
										//viPrplLnCnt:=viPrplLnCnt+1
										PpLnAdd((Size of array:C274(aPLineAction)+1); 1; False:C215)
										pUse:=1
										aPQtyOrder{aPLineAction}:=<>rQQAddQty
										pQtyShip:=<>rQQAddQty
										If (<>vtMore#"")
											aPLnComment{aoLineAction}:=<>vtMore
										End if 
										If (<>vrPrice#0)
											If (<>vrPrice=-0.001)
												<>vrPrice:=0
											End if 
											aPUnitPrice{aoLineAction}:=<>vrPrice
										End if 
										If (<>vrCost#0)
											If (<>vrCoslwcssert=-0.001)
												<>vrCost:=0
											End if 
											aPUnitCost{aoLineAction}:=<>vrCost
										End if 
										PpLnExtend(aPLineAction)
								End case 
								
							End for 
							Case of 
								: (ptCurTable=(->[Order:3]))
									//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
									QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101115
								: (ptCurTable=(->[Invoice:26]))
									//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)
									QQSetColor(eIvcList; ->aiItemNum)  //###_jwm_### 20101115
								: (ptCurTable=(->[PO:39]))
									//  --  CHOPPED  AL_UpdateArrays(ePoList; -2)
									QQSetColor(ePOList; ->aPoItemNum)  //###_jwm_### 20101115
								: (ptCurTable=(->[Proposal:42]))
									//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
									QQSetColor(ePropList; ->aPItemNum)  //###_jwm_### 20101115
							End case 
						End if 
					End if 
				End if 
			: (ptCurTable=(->[SpecialDiscount:44]))
				CONFIRM:C162("Add Items to "+[SpecialDiscount:44]typeSale:1)
				If (OK=1)
					Disc_AddItems
				End if 
				//: (ptCurFile=([Script]))
				//FlxShip_FillRay 
				////  --  CHOPPED  AL_UpdateArrays (eShipList;-2)
				
				
		End case 
		
	Else 
		BEEP:C151
		BEEP:C151
End case 
<>bQQAddItems:=False:C215
