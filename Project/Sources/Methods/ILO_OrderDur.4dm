//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/18/10, 16:50:59
// ----------------------------------------------------
// Method: ILO_OrderDur
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($vMod; changeOrd; $doExch)
C_REAL:C285($discntPrc)
C_LONGINT:C283($error)
//If (booDuringDo)
MESSAGES OFF:C175
If (doItemList)
	QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101112
	////  --  CHOPPED  AL_UpdateArrays (eItemOrd;-2)    //already in QQSetColor
	// -- AL_SetSelect(eOrdList; aRayLines)
	// -- AL_SetScroll(eOrdList; viVert; viHorz)
	doItemList:=False:C215
End if 
If (ptCurTable#(->[Order:3]))
	Case of 
		: (ptCurTable=(->[Invoice:26]))
			If ((([Order:3]currency:69)#"") & ([Order:3]exchangeRate:68#1) & ([Order:3]exchangeRate:68#0))
				//TRACE
				//strCurrency:=<>tcMONEYCHAR
				//Exch_InitRays (0)
				$doExch:=True:C214
			End if 
		: (ptCurTable=(->[Contact:13]))
			
			//  CHOPPED  ContactsLoad(-1)
	End case 
	//  CHOPPED QA_LoOnEntry(eAnsListOrders; Table(->[Order]); [Order]customerID; [Order]idNum; [Order]idNumTask)
	//jsetDuringIncl(->[Order]; changeOrd)  //File and true if my side button code is used
	
	// into an lines class
	ItemSetButtons((Size of array:C274(aoLineAction)>0); True:C214)
	//entry class
	Ord_Comment(0)
	
	If ($doExch=True:C214)
		$error:=Exch_GetCurr([Order:3]currency:69)  //sets viExConPrec, viExDisPrec    
		Exch_FillRays
		vMod:=calcOrder(vMod)
		vLineMod:=True:C214
	End if 
	HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
	//If (aLineCnts{2}>viOrdLnCnt)
	//viOrdLnCnt:=aLineCnts{2}
	//End if 
	srSO:=[Order:3]idNum:2
	REDRAW WINDOW:C456
	
End if 
C_LONGINT:C283($curRecNum)
$curRecNum:=Record number:C243([Order:3])
If ($curRecNum>-1)  //existing record has changed by coming from another record or backdown from another table
	If (<>aLastRecNum{Table:C252(ptCurTable)}#$curRecNum)  //|($formEvent=On Load))//check if it is loading for the first time
		<>aLastRecNum{Table:C252(ptCurTable)}:=$curRecNum  //remember the current record number to avoid reloading details.
		//jrelateClrFiles (0)
		RelatedRelease
		NxPvOrders
		
		srSO:=[Order:3]idNum:2
		
		jNxPvButtonSet
		curRecNum:=Record number:C243([Order:3])
		<>ptCurTable:=(->[Order:3])
		iLoRecordChange:=True:C214  //set this for managing a one time only setting of values in the iLo Procedure
	End if 
	If (Locked:C147([Order:3]))
		OBJECT SET RGB COLORS:C628(*; "srCustomer"; Yellow:K11:2; Red:K11:4)
		OBJECT SET RGB COLORS:C628(*; "srAcct"; Yellow:K11:2; Red:K11:4)
		OBJECT SET RGB COLORS:C628(*; "srAcct"; Yellow:K11:2; Red:K11:4)
		OBJECT SET RGB COLORS:C628(*; "srZip"; Yellow:K11:2; Red:K11:4)
		OBJECT SET RGB COLORS:C628(*; "srPhone"; Yellow:K11:2; Red:K11:4)
		OBJECT SET RGB COLORS:C628(*; "srSO"; Yellow:K11:2; Red:K11:4)
	End if 
	
End if 
//C_LONGINT($lineNum)
//aLineCnts{2}:=viOrdLnCnt
If ((aPages#FORM Get current page:C276) | (vbNxPvPage))  //changing layout  pages
	//vbNxPvPage:=False//use to adj to menu changes in pages        
	Case of 
		: (aPages=1)  //change to case statement if multiple AreaList on multiple pages            
			
			QQSetColor(eItemOrd; ->aLsItemNum)  //###_jwm_### 20101112
			QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101112
			
		: ((aPages=2) | (aPages=3))  //change to case statement if multiple AreaList on multiple pages            
			
			Profiles_Relate(eProfilesOrder)
			
			
			If (aPages=3)
				Case of 
						
						
				End case 
			End if 
		: (aPages=4)
			// -- AL_SetScroll(eOrdList; 0; 0)
			// -- AL_SetScroll(eItemOrd; 0; 0)
			//  --  CHOPPED  AL_UpdateArrays(eOrdLn2POs; -2)
			// -- AL_SetScroll(eOrdLn2POs; 1; 1)
			//
			COPY ARRAY:C226(aRayLines; aOrdLnSel)
			// -- AL_SetScroll(eOrdLn2POs; viVert; viHorz)
			// -- AL_SetSelect(eOrdLn2POs; aOrdLnSel)
			// -- AL_SetScroll(eOrdMatlDrw; 0; 0)
			// -- AL_SetScroll(eOrdTime; 0; 0)
			// -- AL_SetScroll(eOrdWos; 0; 0)
			// -- AL_SetScroll(eOrdLnCost; 0; 0)
			// -- AL_SetScroll(eProfilesOrder; 0; 0)
			// -- AL_SetScroll(eAnsListOrders; 0; 0)
			// -- AL_SetScroll(eListDocuments; 0; 0)
			//// -- AL_SetScroll (eLoadTagsOrders;0;0)
			//// -- AL_SetScroll (eLoadItemsOrders;0;0)
		: (aPages=5)
			// -- AL_SetScroll(eOrdList; 0; 0)
			// -- AL_SetScroll(eItemOrd; 0; 0)
			// -- AL_SetScroll(eOrdLn2POs; 0; 0)
			// -- AL_SetScroll(eOrdMatlDrw; 1; 1)
			// -- AL_SetScroll(eOrdTime; 1; 1)
			// -- AL_SetScroll(eOrdWos; 1; 1)
			//  --  CHOPPED  AL_UpdateArrays(eOrdLnCost; -2)
			// -- AL_SetScroll(eOrdLnCost; 1; 1)
			// -- AL_SetScroll(eProfilesOrder; 0; 0)
			// -- AL_SetScroll(eAnsListOrders; 0; 0)
			// -- AL_SetScroll(eListDocuments; 0; 0)
			//// -- AL_SetScroll (eLoadTagsOrders;0;0)
			//// -- AL_SetScroll (eLoadItemsOrders;0;0)
			
		: (aPages=6)
			// -- AL_SetScroll(eOrdList; 0; 0)
			// -- AL_SetScroll(eItemOrd; 0; 0)
			// -- AL_SetScroll(eOrdLn2POs; 0; 0)
			// -- AL_SetScroll(eOrdMatlDrw; 1; 1)
			// -- AL_SetScroll(eOrdTime; 1; 1)
			// -- AL_SetScroll(eOrdWos; 1; 1)
			//  --  CHOPPED  AL_UpdateArrays(eOrdLnCost; -2)
			// -- AL_SetScroll(eOrdLnCost; 1; 1)
			// -- AL_SetScroll(eProfilesOrder; 0; 0)
			// -- AL_SetScroll(eAnsListOrders; 1; 1)
			// -- AL_SetScroll(eListDocuments; 0; 0)
			
			
			If (False:C215)
				//  CHOPPED  AL_GetScroll(eOrdMatlDrw; viVert; viHorz)
				// -- AL_SetScroll(eOrdMatlDrw; 1; 1)
				// -- AL_SetSelect(eOrdMatlDrw; aMtlLns)
				// -- AL_SetScroll(eOrdMatlDrw; viVert; viHorz)
				
				//  CHOPPED  AL_GetScroll(eOrdTime; viVert; viHorz)
				// -- AL_SetScroll(eOrdTime; 1; 1)
				// -- AL_SetSelect(eOrdTime; aOrdTimeLns)
				// -- AL_SetScroll(eOrdTime; viVert; viHorz)
				
				//  CHOPPED  AL_GetScroll(aWoStepLns; viVert; viHorz)
				// -- AL_SetScroll(aWoStepLns; 1; 1)
				// -- AL_SetSelect(aWoStepLns; aOrdTimeLns)
				// -- AL_SetScroll(aWoStepLns; viVert; viHorz)
				
				//  --  CHOPPED  AL_UpdateArrays(eOrdLnCost; -2)
				// -- AL_SetScroll(eOrdLnCost; 1; 1)
			End if 
			//// -- AL_SetScroll (eLoadTagsOrders;0;0)
			//// -- AL_SetScroll (eLoadItemsOrders;0;0)
			
		: (aPages=7)
			// -- AL_SetScroll(eOrdList; 0; 0)
			// -- AL_SetScroll(eOrdLn2POs; 0; 0)
			// -- AL_SetScroll(eItemOrd; 0; 0)
			// -- AL_SetScroll(eOrdMatlDrw; 0; 0)
			// -- AL_SetScroll(eOrdTime; 0; 0)
			// -- AL_SetScroll(eOrdWos; 0; 0)
			// -- AL_SetScroll(eOrdLnCost; 0; 0)
			// -- AL_SetScroll(eProfilesOrder; 0; 0)
			// -- AL_SetScroll(eAnsListOrders; 0; 0)
			// -- AL_SetScroll(eListDocuments; 1; 1)
			//// -- AL_SetScroll (eLoadTagsOrders;0;0)
			//// -- AL_SetScroll (eLoadItemsOrders;0;0)
			
		: (aPages=8)
			// -- AL_SetScroll(eOrdList; 0; 0)
			// -- AL_SetScroll(eItemOrd; 0; 0)
			// -- AL_SetScroll(eOrdLn2POs; 0; 0)
			// -- AL_SetScroll(eOrdMatlDrw; 0; 0)
			// -- AL_SetScroll(eOrdTime; 0; 0)
			// -- AL_SetScroll(eOrdWos; 0; 0)
			// -- AL_SetScroll(eOrdLnCost; 0; 0)
			// -- AL_SetScroll(eProfilesOrder; 0; 0)
			// -- AL_SetScroll(eAnsListOrders; 0; 0)
			//// -- AL_SetScroll(eListDocuments; 0; 0)
			//// -- AL_SetScroll (eLoadTagsOrders;1;1)
			//// -- AL_SetScroll (eLoadItemsOrders;1;1)
			
		Else 
			
			If (False:C215)
				// -- AL_SetScroll(eOrdList; 0; 0)
				// -- AL_SetScroll(eItemOrd; 0; 0)
				// -- AL_SetScroll(eOrdLn2POs; 0; 0)
				// -- AL_SetScroll(eOrdMatlDrw; 0; 0)
				// -- AL_SetScroll(eOrdTime; 0; 0)
				// -- AL_SetScroll(eOrdWos; 0; 0)
				// -- AL_SetScroll(eOrdLnCost; 0; 0)
				// -- AL_SetScroll(eProfilesOrder; 0; 0)
				//// -- AL_SetScroll(eListDocuments; 0; 0)
				//// -- AL_SetScroll (eLoadTagsOrders;0;0)
				//// -- AL_SetScroll (eLoadItemsOrders;0;0)
			End if 
	End case 
End if 
If ((FORM Get current page:C276=1) | (FORM Get current page:C276=5))  //something happened while on page 1
	If (doSearch>0)
		ListManageSr(eItemOrd)
	End if   //
	curLines:=Size of array:C274(aoLineAction)
	//TRACE
	If (vLineMod)
		//If (vLineReCalc)
		OrdLnExtend(aoLineAction)
		bCalcNow:=1
		//End if 
		If (FORM Get current page:C276=5)
			//  --  CHOPPED  AL_UpdateArrays(eOrdLnCost; -2)
		End if 
		
		//  CHOPPED  AL_GetScroll(eOrdList; viVert; viHorz)
		viVert:=aoLineAction
		//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)  //eItemOrd
		ARRAY LONGINT:C221(aRayLines; 1)
		aRayLines{1}:=aoLineAction
		// -- AL_SetSelect(eOrdList; aRayLines)
		// -- AL_SetScroll(eOrdList; viVert; viHorz)
		GOTO OBJECT:C206(pQtyOrd)
		
		vLineMod:=False:C215
		vMod:=True:C214  //tests for recalc of total order 
		QQSetColor(eItemOrd; ->aLsItemNum)  //###_jwm_### 20101112
		QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101112     
	End if 
	//If (vMod)
	//Calc_Totals (->[Order]Amount;->[Order]WeightEstimate;->curLines;->viBoxCnt;->aOExtPrice;->aOUnitWt;->aOQtyOrder)
	//End if 
	
	C_LONGINT:C283(bCalcNow)
	C_LONGINT:C283($i; $k)
	If (bCalcNow=1)
		vMod:=calcOrder(True:C214)
	End if 
	
	//End if 
	If (False:C215)
		If (FORM Get current page:C276=1)
			MESSAGES OFF:C175
			vMod:=calcOrder(True:C214)
			MESSAGES ON:C181
		End if 
	End if 
Else 
	////  --  CHOPPED  AL_UpdateArrays (eOrdList;-2)
	////  --  CHOPPED  AL_UpdateArrays (eItemOrd;-2)
	////  --  CHOPPED  AL_UpdateArrays (eOrdLn2POs;-2)
	////  --  CHOPPED  AL_UpdateArrays (eOrdMatlDrw;-2)
	////  --  CHOPPED  AL_UpdateArrays (eOrdWos;-2)
	////  --  CHOPPED  AL_UpdateArrays (eOrdTime;-2)
	////  --  CHOPPED  AL_UpdateArrays (eOrdLnCost;-2)
	//booDuringDo:=True
End if 
booAccept:=([Order:3]customerID:1#"")