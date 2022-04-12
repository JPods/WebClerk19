//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-09T00:00:00, 00:15:07
// ----------------------------------------------------
// Method: POs_iLo
// Description
// Modified: 08/09/13
// 
// 
//
// Parameters
// ----------------------------------------------------


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/18/10, 16:42:51
// ----------------------------------------------------
// Method: Form Method: [PO]iPOs_9
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)

$formEvent:=Form event code:C388

If ($formEvent=On Activate:K2:9)
	If (Size of array:C274(aPoSeq)>0)
		myOK:=1  // ### jwm ### 20190311_1151 do not clear form if a new PO is in process
	End if 
End if 

If ($formEvent=On Unload:K2:2)
	
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		ARRAY LONGINT:C221(aOrdLinesProcessed; 0)  // to prevent duplicate Lines coming from Orders myCycle = 10 or 11
		// weird bug should not occur
		If (vHere>1)  //coming from another table's input layout
			
			If (Is new record:C668([PO:39]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
				If (ptCurTable=(->[AdSource:35]))
					[PO:39]customerPo:34:=[AdSource:35]marketEffort:2
					[PO:39]docType:43:=[AdSource:35]docType:52
					[PO:39]docReference:44:=[AdSource:35]docRef:53
				End if 
			End if 
		End if 
		QQSetColor(ePOList; ->aPoItemNum)  //###_jwm_### 20101115
		QQSetColor(eItemPo; ->aLsItemNum)  //###_jwm_### 20101115
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[PO:39])
	//
	$doMore:=False:C215
	
	Case of 
		: (iLoReturningToLayout)
			
			If (myOK=33)  //roll in
				QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
				PoLnFillRays(Records in selection:C76([POLine:40]))
			End if 
			myOK:=0
			Ord_Comment(0)
			ItemSetButtons((Size of array:C274(aPOLineAction)>0); True:C214)  //activate item control buttons
			$error:=Exch_GetCurr([PO:39]currency:46)  //sets viExConPrec, viExDisPrec
			HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
			srPO:=[PO:39]idNum:5
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			HIGHLIGHT TEXT:C210(srCustomer; 1; Length:C16(srCustomer)+1)
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		myTrap:=0
		NxPvPOs
		booAccept:=changePO
		// ### bj ### 20200129_1935, force on all old POs
		If ([PO:39]idNumTask:69<10)
			TaskIDAssign(->[PO:39]idNumTask:69)
		End if 
		CLEAR VARIABLE:C89(vItemPict)
		LBDocument_ent:=ds:C1482.Document.query("idNumTask = :1"; [PO:39]idNumTask:69)
		
		lbCustomer:="Vendor"
		
		ENABLE MENU ITEM:C149(4; 6)
		ENABLE MENU ITEM:C149(4; 9)
		OBJECT SET ENABLED:C1123(b22; True:C214)
		srPO:=[PO:39]idNum:5
		//
		viPONum:=[PO:39]idNum:5
		vsVendorID:=[PO:39]vendorID:1
		vsVendorInvoiceNum:=""
		vdVendorInvoiceDate:=Current date:C33
		vrVendorInvoiceFreight:=0
		vrVendorInvoiceAmount:=0
		//
		vsVendorPacking:=""
		vdVendorPackDate:=Current date:C33
		TallyMasterPopupScirpts(->[PO:39])
		
		QQSetColor(ePOList; ->aPoItemNum)  //###_jwm_### 20101115
		QQSetColor(eItemPo; ->aLsItemNum)  //###_jwm_### 20101115
		
		
		If (Locked:C147([PO:39]))
			_O_OBJECT SET COLOR:C271(srCustomer; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srAcct; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srZip; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srPhone; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srPO; -(Yellow:K11:2+(256*Red:K11:4)))
		End if 
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	MESSAGES OFF:C175
	If (doItemList)
		//  --  CHOPPED  AL_UpdateArrays(eItemPo; -2)
		doItemList:=False:C215
	End if 
	//aLineCnts{4}:=viPOLnCnt
	If (aPages#FORM Get current page:C276)  //changing layout  pages
		If (aPages>1)  //change to case statement if multiple AreaList on multiple pages
			// -- AL_SetScroll(ePoList; 0; 0)  //deactivate scroll bars of external area
		Else 
			// -- AL_SetScroll(ePoList; 1; 1)  //activate scroll bars of external area
		End if 
	End if 
	If (FORM Get current page:C276=1)  //something happened while on page 1
		////  --  CHOPPED  AL_UpdateArrays (ePoList;-2)
		Case of 
			: (doSearch=888)
				If (vLineMod)
					PoLnExtend(aPOLineAction)
				End if 
				vMod:=calcPO(True:C214)
				acceptPO
				doSearch:=0
			: (doSearch=1000)
				//  --  CHOPPED  AL_UpdateArrays(eItemPo; -2)
				QQSetColor(eItemPo; ->aLsItemNum)  //###_jwm_### 20101115
				doSearch:=0
			: (doSearch>0)
				ListManageSr(eItemPo)
		End case 
		If (vLineMod)
			ARRAY LONGINT:C221(aRayLines; 1)
			aRayLines{1}:=aPOLineAction
			curLines:=Size of array:C274(aPOLineAction)
			PoLnExtend(aPOLineAction)
			PoLnFillVar(aPOLineAction)
			vLineMod:=calcPO(True:C214)
			//  CHOPPED  AL_GetScroll(ePoList; viALVert; viALHorz)
			viVert:=aPOLineAction  //save value of array index setarealine changes it
			//  --  CHOPPED  AL_UpdateArrays(ePoList; -2)
			//// -- AL_SetSort (ePOList;13)//Seq
			//    ARRAY LONGINT(aRayLines;1)
			//  aRayLines{1}:=aPOLineAction
			// -- AL_SetSelect(ePoList; aRayLines)
			viALVert:=aPOLineAction
			// -- AL_SetScroll(ePoList; viALVert; viALHorz)
			QQSetColor(ePOList; ->aPoItemNum)  //###_jwm_### 20101115
			QQSetColor(eItemPo; ->aLsItemNum)  //###_jwm_### 20101115
			vMod:=calcPO(True:C214)
			GOTO OBJECT:C206(pQtyOrd)
		End if 
	End if 
	MESSAGES ON:C181
	booAccept:=True:C214
End if 

