//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:19:30
// ----------------------------------------------------
// Method: PKBarCodeReceive
// Description
// 
//
// Parameters
// ----------------------------------------------------
//
//Script: bF15



C_LONGINT:C283(bF15)
Open window:C153(19; 165; 19; 165; 1)  //(19;165;119;185;1)
DIALOG:C40([Default:15]; "diaBarCode")
CLOSE WINDOW:C154
Case of 
	: (vsBarCdFld=(<>barcodeOther+"o@"))  //find sales order
		srSO:=Num:C11(Substring:C12(vsBarCdFld; 2))
		PkOrderLoad(Num:C11(vsBarCdFld); eOrdList)
	: (vsBarCdFld=(<>barcodeOther+"%o@"))  //find sales order ###_jwm_###
		srSO:=Num:C11(Substring:C12(vsBarCdFld; 2))
		PkOrderLoad(Num:C11(vsBarCdFld); eOrdList)
	: (vsBarCdFld=(<>barcodeOther+"%i@"))  //find Invoice ###_jwm_###
		If (Size of array:C274(aLiItemNum)>0)
			CONFIRM:C162("Clear existing records?")
			If (OK=1)
				vsBarCdFld:=Substring:C12(vsBarCdFld; 3)  //###_jwm_###
				vsBarCdFld:=Replace string:C233(vsBarCdFld; "-"; "")
				srIv:=Num:C11(vsBarCdFld)
				QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=srIv)
				srSO:=[Invoice:26]idNumOrder:1
				PkOrderLoad(srSO; eOrdList)
				QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
				//
				QUERY:C277([LoadTag:88]; [LoadTag:88]idNumInvoice:19=[Invoice:26]idNum:2)
				PKArrayManage(Records in selection:C76([LoadTag:88]))
				If (eShipList>0)
					//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
				End if 
				//
				QUERY:C277([LoadItem:87]; [LoadItem:87]invoiceNum:14=[Invoice:26]idNum:2)
				LT_FillArrayLoadItems(Records in selection:C76([LoadItem:87]))
				If (eLoadList>0)
					//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
				End if 
				//
			End if 
		End if 
	: (vsBarCdFld=(<>barcodeOther+"%p@"))  //package
	: (vsBarCdFld=(<>barcodeOther+"%s@"))  //calls Purpose=PKExecute ###_jwm_###
		vsBarCdFld:=Substring:C12(vsBarCdFld; 3)  //###_jwm_###
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="PKExecute"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=vsBarCdFld)
		If (Records in selection:C76([TallyMaster:60])=1)
			ExecuteText(0; [TallyMaster:60]script:9)
		Else 
			ALERT:C41("No TallyMasters Record"+"\r"+"Named: "+vsBarCdFld+"\r"+"Purpose: PKExecute")
		End if 
		//
	: (<>pkScaleComment="Weight Mismatch")
		BEEP:C151
		BEEP:C151
		BEEP:C151
		//<>pkScaleComment:="FULLY SHIPPED"
		PKAlertWindow
	Else   //}first in
		PKBarCodeItem
End case 