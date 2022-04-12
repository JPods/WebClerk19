//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/17/11, 10:59:41
// ----------------------------------------------------
// Method: NxPvOrders
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150109_1137 changed DateNeeded to DateOrdered

C_BOOLEAN:C305(newOrd; changeOrd)
C_DATE:C307(releaseDate)
C_TIME:C306(releaseTime)
C_BOOLEAN:C305(vbNxPvPage; $newOrd; $1)
C_LONGINT:C283(eProfilesOrder)
$newOrd:=(Is new record:C668([Order:3]))
If (allowAlerts_boo)
	//Pro_FillArray (-9;3;[Order]OrderNum;"")  //AreaList must be defined first    // ### jwm ### 20180222_1412  // ### jwm ### 20180222_1412
	//  --  CHOPPED TC_FillArrays(0)
	//  --  CHOPPED MD_FillArrays(0)
	//  --  CHOPPED WO_FillArrays(0)  //define arrays before al defines in NxPv
	//  --  CHOPPED  Doc_FillArrays(0)
	C_LONGINT:C283(eOrdList)
	
	//  --  CHOPPED  AL_UpdateArrays(eProfilesOrder; -2)
	If (myCycle#4)  //crashing from Proposals, double run, maybe should be at end
		//  CHOPPED QA_LoOnEntry(eAnsListOrders; Table(->[Order]); [Order]customerID; [Order]idNum; [Order]idNumTask)
	End if 
Else 
	If (Count parameters:C259=1)  //build order without new num for web
		$newOrd:=$1
	End if 
End if 
//
vOrdTime:=0
vOrdMtl:=0
vOrdWos:=0
vbNxPvPage:=False:C215
vMod:=False:C215
bNewRec:=0
myTrap:=0  //used in the vRunning Balance 
//TRACE
If (Record number:C243([Order:3])>-1)  //will always be false during EDI PO Recvs
	HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
	If (Locked:C147([Order:3]))
		BEEP:C151
		//  jAlertMessage (10004)  already warned
		OBJECT SET ENABLED:C1123(bInvoice; False:C215)
	End if 
	If ([Order:3]customerID:1#[Customer:2]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
	End if 
	//TaxFindSales (->sTaxRate;->[Order]TaxJuris;->[Customer]TaxExemptID;->doTax;->[Order]TaxRate)
	//  setShipArray 
	//
	
	changeOrd:=True:C214
	If (allowAlerts_boo)  // Modified by: williamjames (110224)
		changeOrd:=(UserInPassWordGroup("EditOrder"))
		If (changeOrd=False:C215)
			
			If (False:C215)
				If ((changeOrd=False:C215) & (Not:C34(Locked:C147([Order:3]))))
					MESSAGE:C88("Password does not allow changes to be saved.")
					C_LONGINT:C283($curRec)
					$curRec:=Record number:C243([Order:3])
					//GOTO RECORD([Order];$curRec)
					vText1:="READ ONLY([Order])"+"\r"+"GOTO RECORD([Order];"+String:C10($curRec)+")"
					DB_ShowCurrentSelection(Table:C252(curTableNum); vText1; 11; ""; 2)  //$5 keeps current selection
					CANCEL:C270
				End if 
			End if 
		End if 
	End if 
	//
	If (Record number:C243([Order:3])>-1)
		<>aLastRecNum{3}:=Record number:C243([Order:3])
		// ### bj ### 20181204_1145
		// should get rid of this 
		// should only be in iLoProcedure
	End if 
	If (Record number:C243([Customer:2])>-1)
		<>aLastRecNum{2}:=Record number:C243([Customer:2])
	End if 
	OrdLnFillRays
	setCustFinance
	If (myCycle=4)  //coming from Proposals
		TRACE:C157
		createOrderProp  //must follow OrdLnFillRays
		booWarn:=False:C215
		setCustFinance
		
	End if 
	ENABLE MENU ITEM:C149(2; 7)
Else 
	
	
	If (allowAlerts_boo)
		DISABLE MENU ITEM:C150(2; 7)
		srDisplayEmail:=""
	End if 
	OrdersCreateNew($newOrd)
	
	If (<>passMeText1#"")  //coming from serial numbers
		[Order:3]customerPO:3:=<>passMeText1
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]serialNum:4=<>passMeText1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[ItemSerial:47]customerID:9)
		If (Records in selection:C76([Customer:2])>0)
			myCycle:=3
		End if 
		<>passMeText1:=""
	End if 
	//each case below must call OrdLnFillRays(0)  
	Case of 
		: (myCycle=4)  //coming from Proposals
			Ord_FromProposal
		: ((myCycle=3) | (vHere>2))
			LoadCustOrder
			OrdLnRays(0)
			If (<>tcNeedDelay>-1)
				[Order:3]dateNeeded:5:=Current date:C33+<>tcNeedDelay
				[Order:3]dateShipOn:31:=Current date:C33+<>tcNeedDelay
			End if 
		Else 
			vCreditStat:=""
			booWarn:=True:C214
			If (False:C215)  //(<>LoadCustomerRecord>-1)
				If (<>LoadCustomerRecord#Record number:C243([Customer:2]))
					GOTO RECORD:C242([Customer:2]; <>LoadCustomerRecord)
				End if 
				LoadCustOrder
			Else 
				REDUCE SELECTION:C351([Customer:2]; 0)
			End if 
			ARRAY TEXT:C222(aContact; 0)
			REDUCE SELECTION:C351([Payment:28]; 0)
			InitSalesVar
			OrdLnRays(0)
			bNewRec:=0
			If (allowAlerts_boo)
				FontSrchLabels(1)
			End if 
			If (<>tcNeedDelay>-1)
				[Order:3]dateNeeded:5:=Current date:C33+<>tcNeedDelay
				[Order:3]dateShipOn:31:=Current date:C33+<>tcNeedDelay
			End if 
			
			// ### bj ### 20181204_1141
			// at the end so [Proposal]taskID can be transferred if existing
			TaskIDAssign(->[Order:3]idNumTask:85)
			// all orders will be assigned a taskID even if not used.
			// this simplifies WorkOrders and documents
			
	End case 
	QQSetColor(eOrdList; ->aOItemNum)
	[Order:3]dateDocument:4:=Current date:C33
	[Order:3]timeOrdered:58:=Current time:C178
	If (<>tcCancelBy>0)
		[Order:3]dateCancel:53:=[Order:3]dateNeeded:5+<>tcCancelBy
	End if 
	[Order:3]autoFreight:40:=(<>tcAutoFrght=1)
	[Order:3]fob:45:=Storage:C1525.default.fob
End if 

If ([Order:3]siteID:106="")
	[Order:3]siteID:106:=DSGetMachineSiteID
End if 
vsiteID:=[Order:3]siteID:106
//

bAltBillBox:=Num:C11([Order:3]addressBillTo:71#"")
bAltShipBox:=Num:C11([Order:3]addressShipFrom:72#"")
booAccept:=([Order:3]customerID:1#"")  //&(changeOrd))
vComRep:=CM_FindRate(->[Order:3]repID:8; -><>aReps; -><>aRepRate)
vComSales:=CM_FindRate(->[Order:3]salesNameID:10; -><>aComNameID; -><>aEmpRate)
QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
If (allowAlerts_boo)
	PayLoadShow(Records in selection:C76([Payment:28]))
Else 
	REDUCE SELECTION:C351([Payment:28]; 0)
	PayLoadShow(0)
End if 
REDUCE SELECTION:C351([POLine:40]; 0)
If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
	//DscntSetPrice ([Order]TypeSale;[Order]DateNeeded)
	DscntSetPrice([Order:3]typeSale:22; [Order:3]dateDocument:4)  // ### jwm ### 20150109_1137 changed DateNeeded to DateOrdered
Else 
	DscntSpecialClr([Order:3]typeSale:22)
End if 
curRecNum:=Selected record number:C246([Order:3])
jDateTimeRecov([Order:3]dtProdRelease:56; ->releaseDate; ->releaseTime)
jDateTimeRecov([Order:3]dtProdCompl:57; ->complDate; ->complTime)
aoLineAction:=Num:C11(Size of array:C274(aoLineAction)>0)  //the first line is the default highlight
ARRAY LONGINT:C221(aRayLines; 1)
aRayLines{1}:=aoLineAction
doSearch:=0

vLineMod:=False:C215
vMod:=False:C215
curLines:=Size of array:C274(aoLineAction)
ARRAY LONGINT:C221(aOrdLnSel; 0)  //area list of selected lines
strCurrency:=""  //[Order]Currency//must not be set
//
If (allowAlerts_boo)
	//jrelateClrFiles // Modified by: williamjames (9/17/09)  Always relate
	RelatedRelease
	If ((<>tcMONEYCHAR#[Order:3]currency:69) & ([Order:3]currency:69#"") & (<>tcMONEYCHAR#""))
		$error:=Exch_GetCurr([Order:3]currency:69)  //sets viExConPrec, viExDisPrec    
		Exch_FillRays
		vMod:=calcOrder(vMod)
	End if 
	Ln_FillVar(aoLineAction; ->aOItemNum; ->aODescpt; 0; aOQtyOrder{aoLineAction}; aOQtyBL{aoLineAction}; aOUnitPrice{aoLineAction}; aODiscnt{aoLineAction}; aOExtPrice{aoLineAction}; aOPricePt{aoLineAction})
	//
	//  Put  the formating in the form  jFormatPhone(->[Order]phone)
	OBJECT SET ENTERABLE:C238([Order:3]shipMiscCosts:25; Not:C34([Order:3]autoFreight:40))
	OBJECT SET ENTERABLE:C238([Order:3]shipFreightCost:38; Not:C34([Order:3]autoFreight:40))
	OBJECT SET FORMAT:C236(aPayShow; "###,###.00 ;###,###.00-")
	OBJECT SET FORMAT:C236(pUnitPrice; <>tcFormatUP)
	If (eOrdList#0)
		//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
		// -- AL_SetSelect(eOrdList; aRayLines)  //first element in AreaList is always selected 
	End if 
	ItemSetButtons((Size of array:C274(aoLineAction)>0); True:C214)
	//
	$doChange:=(UserInPassWordGroup("ChangesalesNameID"))
	If (Not:C34($doChange))
		OBJECT SET ENTERABLE:C238([Customer:2]salesNameID:59; False:C215)
		OBJECT SET ENTERABLE:C238([Order:3]salesNameID:10; False:C215)
	End if 
	$doChange:=(UserInPassWordGroup("ViewCommission"))
	If ((Not:C34($doChange)) & (Current user:C182#[Order:3]salesNameID:10))
		C_LONGINT:C283($theColor)
		$theColor:=14
		_O_OBJECT SET COLOR:C271([Order:3]salesCommission:11; -$theColor+(256*$theColor))
		_O_OBJECT SET COLOR:C271(vComSales; -$theColor+(256*$theColor))
	End if 
	If ((Not:C34($doChange)) & (Current user:C182#[Order:3]repID:8))
		C_LONGINT:C283($theColor)
		$theColor:=14
		_O_OBJECT SET COLOR:C271([Order:3]repCommission:9; -$theColor+(256*$theColor))
		_O_OBJECT SET COLOR:C271(vComRep; -$theColor+(256*$theColor))
	End if 
	
	
End if 
pCCDateStr:=Date_StrMMYY([Customer:2]creditCardExpir:54)
//Format_CreditCd (->[Customer]CreditCardNum)

C_BOOLEAN:C305(vbdTime; vbdMtls; vbdWos)
vbdTime:=False:C215
vbdMtls:=False:C215
vbdWos:=False:C215
//aLineCnts{2}:=viOrdLnCnt
MESSAGES ON:C181
//
Ord_Comment(0)  // ### jwm ### 20190826_1620n too verbose alert message gets lost



REDRAW WINDOW:C456
