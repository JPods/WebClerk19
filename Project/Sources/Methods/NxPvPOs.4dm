//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 04/12/13, 11:35:28
// ----------------------------------------------------
// Method: NxPvPOs
// Description
// File: NxPvPOs.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130412_1134 added vsiteID

If (Is new record:C668([PO:39]))
	POBasicsNew
	
	viPOLnCnt:=0
	If (myOK=0)
		REDUCE SELECTION:C351([Vendor:38]; 0)
		srVarLoad(0)
	Else 
		myOK:=0
		loadVendor2PO
	End if 
	FontSrchLabels(1)
	DISABLE MENU ITEM:C150(2; 4)  //no cloning new records   
	DISABLE MENU ITEM:C150(2; 7)
	If (<>passMeText1#"")
		[PO:39]customerPo:34:=<>passMeText1
		<>passMeText1:=""
	End if 
	//### jwm ### 20130412_1134 added vsiteID
	[PO:39]siteID:74:=DSGetMachineSiteID
	vsiteID:=[PO:39]siteID:74
Else 
	HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
	changePo:=(UserInPassWordGroup("EditPO"))
	
	If (Not:C34(changePo))
		MESSAGE:C88("Password does not allow changes to be saved.")
	End if 
	ENABLE MENU ITEM:C149(2; 7)
	If ([PO:39]vendorID:1="")
		srVarLoad(0)
		FontSrchLabels(1)
	Else 
		If ([PO:39]vendorID:1#[Vendor:38]vendorID:1)
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
		End if 
		If (Records in selection:C76([Vendor:38])=1)
			FontSrchLabels(3)
			OBJECT SET ENTERABLE:C238(srCustomer; False:C215)
			OBJECT SET ENTERABLE:C238(srPhone; False:C215)
			OBJECT SET ENTERABLE:C238(srAcct; False:C215)
			OBJECT SET ENTERABLE:C238(srZip; False:C215)
		End if 
		loadVendor2PO
	End if 
	newPo:=False:C215
End if 

If ([PO:39]siteID:74="")
	[PO:39]siteID:74:=DSGetMachineSiteID
End if 
vsiteID:=[PO:39]siteID:74


If (Is new record:C668([PO:39]))
	// ### jwm ### 20190311_1256 do not update arrays
Else 
	QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
	PoLnFillRays(Records in selection:C76([POLine:40]))
End if 

If (myCycle#0)
	PO_AddNewLines
End if 
myCycle:=0
myOK:=0
booMod:=False:C215  //needed to keep track of creating new Part Nums.
OBJECT SET FORMAT:C236(pUnitPrice; <>tcFormatUC)
doSearch:=0
vLineMod:=False:C215
//
C_LONGINT:C283($error)
strCurrency:=""
If ((<>tcMONEYCHAR#[PO:39]currency:46) & ([PO:39]currency:46#"") & (<>tcMONEYCHAR#""))
	$error:=Exch_GetCurr([PO:39]currency:46)  //sets viExConPrec, viExDisPrec   
	Exch_FillRays
	vMod:=calcPO(vMod)
End if 
//
If (allowAlerts_boo)
	C_LONGINT:C283(ePoList)
	//  Put  the formating in the form  jFormatPhone(->[PO]phone; ->[PO]fax)
	//  Put  the formating in the form  jFormatPhone(->[Vendor]phone; ->[Vendor]fax; ->srPhone)
	If (ePoList>0)
		//  --  CHOPPED  AL_UpdateArrays(ePoList; -2)
		aPOLineAction:=Num:C11(Size of array:C274(aPOLineAction)>0)  //the first line is the default highlight
		ARRAY LONGINT:C221(aRayLines; aPOLineAction)
		If (aPOLineAction=1)
			aRayLines{1}:=aPOLineAction
			// -- AL_SetSelect(ePoList; aRayLines)  //first element in AreaList is always selected 
		End if 
	End if 
	PoLnFillVar(aPOLineAction)
	ItemSetButtons((aPOLineAction=1); True:C214)
	Ord_Comment(0)
	////  CHOPPED QA_LoOnEntry (eAnsListPos;"";0;->[PO]taskID)
	//  CHOPPED QA_LoOnEntry(eAnsListPos; Table(->[PO]); [PO]vendorID; [PO]idNum; [PO]idNumTask)
End if 
//
curLines:=Records in selection:C76([POLine:40])
//vlReceiptID:=0
//
ARRAY LONGINT:C221(aSrPendAct; 0)  //initialize the array for tracking changes in serial numbers
//1, add; 2, issue; 3, purchase; 4, delete (return)
ARRAY LONGINT:C221(aSrPendRec; 0)
ARRAY LONGINT:C221(aSrPendLn; 0)
//

REDRAW WINDOW:C456