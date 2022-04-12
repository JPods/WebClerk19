//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/6/02
	//Who: Dan Bentson, Arkware
	//Description: default DateNeeded
	VERSION_960
End if 
C_BOOLEAN:C305($1; $doNew)
$doNew:=True:C214
If (Count parameters:C259=1)
	$doNew:=$1
End if 
OBJECT SET ENABLED:C1123(bSubDel; False:C215)
bNewRec:=0
vMod:=False:C215
booAccept:=True:C214
//nOrderFile:=1
If (Is new record:C668([Proposal:42]))
	[Proposal:42]action:96:="Close with Customer"
	[Proposal:42]actionBy:94:=Current user:C182
	[Proposal:42]actionDate:95:=Current date:C33+3
	[Proposal:42]actionTime:58:=?07:31:00?
	
	
	[Proposal:42]salesNameID:9:=Current user:C182
	[Proposal:42]status:2:="Open"
	[Proposal:42]complete:56:=False:C215
	[Proposal:42]dateDocument:3:=Current date:C33
	[Proposal:42]totalCost:23:=0
	[Proposal:42]amount:26:=0
	[Proposal:42]salesTax:27:=0
	[Proposal:42]shipTotal:31:=0
	[Proposal:42]total:32:=0
	[Proposal:42]dateExpected:42:=!00-00-00!
	If (<>tcNeedDelay>-1)
		[Proposal:42]dateNeeded:4:=Current date:C33+<>tcNeedDelay
	End if 
	[Proposal:42]probability:43:=0
	[Proposal:42]daysValidFor:39:=30
	[Proposal:42]takenBy:61:=Current user:C182
	// ### bj ### 20181204_1141
	TaskIDAssign(->[Proposal:42]idNumTask:70)
	// all orders will be assigned a taskID even if not used.
	// this simplifies WorkOrders and documents
	vr2:=0
	InitSalesVar
	If ($doNew)
		[Proposal:42]idNum:5:=CounterNew(->[Proposal:42])
	End if 
	newProp:=True:C214
	[Proposal:42]autoFreight:38:=(<>tcAutoFrght=1)
	Case of 
		: (<>LoadCustomerRecord>-1)
			If (<>LoadCustomerRecord#Record number:C243([Customer:2]))
				GOTO RECORD:C242([Customer:2]; <>LoadCustomerRecord)
			End if 
			setCustFinance
			ProposalLoadCus
			OBJECT SET ENABLED:C1123(b21; True:C214)
			DISABLE MENU ITEM:C150(2; 7)
		: (Record number:C243([Customer:2])>-1)
			setCustFinance
			ProposalLoadCus
			OBJECT SET ENABLED:C1123(b21; True:C214)
			DISABLE MENU ITEM:C150(2; 7)
		: (vHere>2)  //Test for access direct from the customer
			setCustFinance
			ProposalLoadCus
			OBJECT SET ENABLED:C1123(b21; True:C214)
			DISABLE MENU ITEM:C150(2; 7)
		Else 
			ENABLE MENU ITEM:C149(2; 7)
			REDUCE SELECTION:C351([Customer:2]; 0)
			ARRAY TEXT:C222(aContact; 0)
			REDUCE SELECTION:C351([Service:6]; 0)
			vComRep:=0
			vComSales:=0
			If (allowAlerts_boo)
				FontSrchLabels(1)
				
			End if 
	End case 
Else 
	HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
	newProp:=False:C215
	If ([Proposal:42]customerID:1#[Customer:2]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
	End if 
	vComRep:=CM_FindRate(->[Proposal:42]repID:7; -><>aReps; -><>aRepRate)
	vComSales:=CM_FindRate(->[Proposal:42]salesNameID:9; -><>aComNameID; -><>aEmpRate)
	OBJECT SET ENABLED:C1123(b21; True:C214)
	setCustFinance
	//TaxFindSales (->sTaxRate;->[Proposal]TaxJuris;->[Customer]TaxExemptID;->doTax)
End if 
//
If ([Proposal:42]siteID:77="")
	[Proposal:42]siteID:77:=DSGetMachineSiteID
End if 
vsiteID:=[Proposal:42]siteID:77
//
QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
PpLnFillRays(Records in selection:C76([ProposalLine:43]))
If ((myCycle=22) & (Is new record:C668([Service:6])))
	myCycle:=0
	viPrplLnCnt:=viPrplLnCnt+1
	//Item_Add2Doc
	[Proposal:42]idNumTask:70:=[Service:6]idNumTask:51
End if 
OBJECT SET ENTERABLE:C238([Proposal:42]shipMiscCosts:29; Not:C34([Proposal:42]autoFreight:38))
OBJECT SET ENTERABLE:C238([Proposal:42]shipFreightCost:30; Not:C34([Proposal:42]autoFreight:38))
curRecNum:=Selected record number:C246([Proposal:42])
booPreNext:=False:C215
If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
	DscntSetPrice([Proposal:42]typeSale:20; [Proposal:42]dateNeeded:4)
Else 
	DscntSpecialClr([Proposal:42]typeSale:20)
End if 

If (allowAlerts_boo)  //all these edi blocks could be consolidated.  No time
	//  Put  the formating in the form  jFormatPhone(->[Proposal]phone)
	OBJECT SET FORMAT:C236(pUnitPrice; <>tcFormatUP)
	OBJECT SET FORMAT:C236(pUnitCost; <>tcFormatUC)
	//If (Size of array(acShipCo)=0)
	//setShipArray 
	//Else 
	//If (acShipCo{1}#[Customer]Customer)
	//setShipArray 
	//End if 
	//End if 
	//  
	
	$doChange:=(UserInPassWordGroup("ViewCommission"))
	If (Not:C34($doChange))
		C_LONGINT:C283($theColor)
		$theColor:=14
		_O_OBJECT SET COLOR:C271([Proposal:42]repCommission:8; -$theColor+(256*$theColor))
		_O_OBJECT SET COLOR:C271([Proposal:42]salesCommission:10; -$theColor+(256*$theColor))
		_O_OBJECT SET COLOR:C271(vComSales; -$theColor+(256*$theColor))
		_O_OBJECT SET COLOR:C271(vComRep; -$theColor+(256*$theColor))
	End if 
	$doChange:=(UserInPassWordGroup("ChangesalesNameID"))
	
	If (Not:C34($doChange))
		OBJECT SET ENTERABLE:C238([Customer:2]salesNameID:59; False:C215)
		OBJECT SET ENTERABLE:C238([Proposal:42]salesNameID:9; False:C215)
	End if 
	jrelateClrFiles
End if 
//
doSearch:=0
strCurrency:=""
If (allowAlerts_boo)
	If ((<>tcMONEYCHAR#[Proposal:42]currency:55) & ([Proposal:42]currency:55#"") & (<>tcMONEYCHAR#""))
		$error:=Exch_GetCurr([Proposal:42]currency:55)  //sets viExConPrec, viExDisPre  
		Exch_FillRays
		vMod:=calcProposal(True:C214)
	End if 
	//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
	// -- AL_SetSelect(ePropList; aRayLines)  //first element in AreaList is always selected 
	Ln_FillVar(aPLineAction; ->aPItemNum; ->aPDescpt; Num:C11(aPUse{aPLineAction}#""); aPQtyOrder{aPLineAction}; 0; aPUnitPrice{aPLineAction}; aPDiscnt{aPLineAction}; aPExtPrice{aPLineAction}; aPPricePt{aPLineAction})
	<>aLastRecNum{2}:=Record number:C243([Customer:2])
	ItemSetButtons((Size of array:C274(aPLineAction)>0); True:C214)
	//  CHOPPED QA_LoOnEntry(eAnsListPp; Table(->[Proposal]); [Proposal]customerID; [Proposal]idNum; [Proposal]idNumTask)
	////  CHOPPED QA_LoOnEntry (eAnsListPp;"";0;->[Proposal]taskID)
End if 
aPLineAction:=Num:C11(Size of array:C274(aPLineAction)>0)  //the first line is the default highlight
ARRAY LONGINT:C221(aRayLines; aPLineAction)
If (aPLineAction=1)
	aRayLines{1}:=aPLineAction
End if 
//
vLineMod:=False:C215
curLines:=Size of array:C274(aPLineAction)
