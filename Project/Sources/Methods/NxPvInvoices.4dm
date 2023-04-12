//%attributes = {"publishedWeb":true}
If (vHere>2)
	ENABLE MENU ITEM:C149(2; 24)
End if 
srVarLoad(2)
//srCustomer:=[Customer]Company
//srPhone:=[Customer]Phone
//srAcct:=[Customer]customerID
//srZip:=[Customer]Zip
//SerRecRayArea 
//SerRecRayInit (0;(vHere<3))//coming from another iLout
//ShipRecRayInit(0;False)
C_BOOLEAN:C305(vModLoadTags; vHasLoadTags)
vModLoadTags:=False:C215
vHasLoadTags:=False:C215
QUERY:C277([LoadTag:88]; [LoadTag:88]idNumInvoice:19=[Invoice:26]idNum:2)
If (Records in selection:C76([LoadTag:88])>0)
	vHasLoadTags:=True:C214
End if 
If ([Invoice:26]siteID:86="")
	[Invoice:26]siteID:86:=DSGetMachineSiteID
End if 
vsiteID:=[Invoice:26]siteID:86
//TaxFindSales (->sTaxRate;->[Invoice]TaxJuris;->[Customer]TaxExemptID;->doTax)
vComRep:=CM_FindRate(->[Invoice:26]repID:22; -><>aReps; -><>aRepRate)
vComSales:=CM_FindRate(->[Invoice:26]salesNameID:23; -><>aComNameID; -><>aEmpRate)
//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->[Customer]fax; ->srPhone)
//  Put  the formating in the form  jFormatPhone(->[Invoice]phone)
bAltBillBox:=Num:C11([Invoice:26]addressBillTo:67#"")
bAltShipBox:=Num:C11([Invoice:26]addressShipFrom:68#"")
If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
	DscntSetPrice([Invoice:26]typeSale:49; <>ptInvoiceDateFld->)
Else 
	DscntSpecialClr([Invoice:26]typeSale:49)
End if 
If (Record number:C243([Invoice:26])>-1)
	[Invoice:26]shipAuto:32:=False:C215
	SAVE RECORD:C53([Invoice:26])
End if 
//Added the EDI block on Thursday, December 10, 1998
If (allowAlerts_boo)  //all these edi blocks could be consolidated.  No time
	If (Is new record:C668([Invoice:26]))
		changeInv:=True:C214
	Else 
		changeInv:=(UserInPassWordGroup("EditInvoice"))
	End if 
	If (Is new record:C668([Invoice:26]))
		changeInvLines:=True:C214
	Else 
		changeInvLines:=(UserInPassWordGroup("EditInvoiceLine"))
	End if 
	$doChange:=(UserInPassWordGroup("ChangesalesNameID"))
	If (Not:C34($doChange))
		OBJECT SET ENTERABLE:C238([Customer:2]salesNameID:59; False:C215)
		OBJECT SET ENTERABLE:C238([Invoice:26]salesNameID:23; False:C215)
	End if 
	$doChange:=UserInPassWordGroup("ViewCommission")
	If ((Not:C34($doChange)) & (Current user:C182#[Invoice:26]salesNameID:23))
		C_LONGINT:C283($theColor)
		$theColor:=14
		OBJECT SET RGB COLORS:C628(*; "[Invoice]salesCommission"; $theColor; 256*$theColor)
		OBJECT SET RGB COLORS:C628(*; "vComSales"; $theColor; 256*$theColor)
	End if 
	If ((Not:C34($doChange)) & (Current user:C182#[Invoice:26]repID:22))
		C_LONGINT:C283($theColor)
		$theColor:=14
		OBJECT SET RGB COLORS:C628(*; "[Invoice]repCommission"; $theColor; 256*$theColor)
		OBJECT SET RGB COLORS:C628(*; "vComRep"; $theColor; 256*$theColor)
	End if 
	
	// ### jwm ### 20160219_1240 get current window Title
	C_TEXT:C284($currentTitle)
	$currentTitle:=Get window title:C450
	
	Case of 
		: ((<>vbLockInvAtPrint=True:C214) & ([Invoice:26]timesPrinted:51>0))
			SET WINDOW TITLE:C213("PRINT LOCKED, "+$currentTitle)
			$doChange:=(UserInPassWordGroup("UnlockRecord"))
			If (Not:C34($doChange))
				READ ONLY:C145([Invoice:26])
				LOAD RECORD:C52([Invoice:26])
				READ WRITE:C146([Invoice:26])
			End if 
		: (([Invoice:26]dateLinked:31#!00-00-00!) | ([Invoice:26]jrnlComplete:48) | (Not:C34(changeInv)))
			If (allowAlerts_boo)
				//MESSAGE("Locked to changes")
			End if 
			SET WINDOW TITLE:C213("LINKED, "+$currentTitle)
			
			OBJECT SET ENTERABLE:C238([Invoice:26]shipAdjustments:17; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]repCommission:28; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]salesCommission:36; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]attention:38; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]company:7; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]address1:8; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]address2:9; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]city:10; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]state:11; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]zip:12; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]country:13; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]shipFreightCost:15; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]shipMiscCosts:16; False:C215)
			OBJECT SET ENTERABLE:C238([Invoice:26]timesPrinted:51; False:C215)
			//
			OBJECT SET ENABLED:C1123(bNewRec; False:C215)
			OBJECT SET ENABLED:C1123(bSubAdd; False:C215)
			OBJECT SET ENABLED:C1123(bSubDel; False:C215)
			OBJECT SET ENTERABLE:C238(pPartNum; False:C215)
			OBJECT SET ENTERABLE:C238(pQtyShip; False:C215)
			OBJECT SET ENTERABLE:C238(pPricePt; False:C215)
			OBJECT SET ENTERABLE:C238(pUnitPrice; False:C215)
			OBJECT SET ENTERABLE:C238(pDiscnt; False:C215)
			
		: (([Invoice:26]idNumOrder:1=1) & (changeInvLines))
			OBJECT SET ENTERABLE:C238(pPartNum; True:C214)
			OBJECT SET ENTERABLE:C238(pPricePt; True:C214)
			OBJECT SET ENTERABLE:C238(pUnitPrice; True:C214)
			OBJECT SET ENTERABLE:C238(pDiscnt; True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(pPartNum; False:C215)
			OBJECT SET ENTERABLE:C238(pQtyShip; False:C215)
			OBJECT SET ENTERABLE:C238(pPricePt; False:C215)
			OBJECT SET ENTERABLE:C238(pUnitPrice; False:C215)
			OBJECT SET ENTERABLE:C238(pDiscnt; False:C215)
	End case 
	//DISABLE ITEM(2;1)//no cloning new records  
	If (newInv)
		DISABLE MENU ITEM:C150(2; 7)
	Else 
		ENABLE MENU ITEM:C149(2; 7)
	End if 
	If ([Invoice:26]balanceDue:44=0)
		OBJECT SET ENABLED:C1123(bPayment; False:C215)
	Else 
		OBJECT SET ENABLED:C1123(bPayment; True:C214)
	End if 
	// already in RelatedRelease
	
	// Modified by: Bill James (2015-02-07T00:00:00 Fix Payments with No OrderNum)
	If (False:C215)
		If ([Invoice:26]idNumOrder:1<9)
			QUERY:C277([Payment:28]; [Payment:28]idNumInvoice:3=[Invoice:26]idNum:2; *)
			QUERY:C277([Payment:28];  | [Payment:28]amountAvailable:19#0; *)
			QUERY:C277([Payment:28];  & [Payment:28]customerID:4=[Customer:2]customerID:1)
		Else 
			QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Invoice:26]idNumOrder:1; *)
			QUERY:C277([Payment:28];  | [Payment:28]idNumInvoice:3=[Invoice:26]idNum:2)
			<>aLastRecNum{Table:C252(->[Order:3])}:=Record number:C243([Order:3])
		End if 
		PayLoadShow(Records in selection:C76([Payment:28]))
	End if 
	//
	OBJECT SET ENTERABLE:C238([Invoice:26]shipFreightCost:15; Not:C34([Invoice:26]shipAuto:32))
	OBJECT SET ENTERABLE:C238([Invoice:26]shipMiscCosts:16; Not:C34([Invoice:26]shipAuto:32))
	//<>tcAutoFrght:=Num([Invoice]shipAuto=True)
	//
	vrOldValue:=[Order:3]amountBackLog:54
	//
	booAccept:=True:C214
	MESSAGES OFF:C175
	If ([Invoice:26]dateLinked:31#!00-00-00!)
		lockedMsg:="This invoice has been linked to accounting, NO CHANGES permitted."
	Else 
		lockedMsg:=""
	End if 
	//   ENABLE ITEM(5;5)
	curRecNum:=Selected record number:C246([Invoice:26])
	MESSAGES ON:C181
	
	
	strCurrency:=""
	If ((<>tcMONEYCHAR#[Invoice:26]currency:62) & ([Invoice:26]currency:62#"") & (<>tcMONEYCHAR#""))
		$error:=Exch_GetCurr([Invoice:26]currency:62)  //sets viExConPrec, viExDisPrec  
		Exch_FillRays
		vMod:=calcInvoice(vMod)
	End if 
	
	
	OBJECT SET FORMAT:C236(pUnitPrice; <>tcFormatUP)
	doSearch:=0
	//   IvcLnFillVar(aiLineAction)
	ItemSetButtons((Size of array:C274(aiLineAction)>0); Not:C34(([Invoice:26]jrnlComplete:48=True:C214) | (changeInv=False:C215)))
	vLineMod:=False:C215
	//
	ARRAY LONGINT:C221(aSrPendAct; 0)  //initialize the array for tracking changes in serial numbers
	//1, add; 2, issue; 3, purchase; 4, delete (return)
	ARRAY LONGINT:C221(aSrPendRec; 0)
	ARRAY LONGINT:C221(aSrPendLn; 0)
	
	
End if 


Ord_Comment(0)


REDRAW WINDOW:C456