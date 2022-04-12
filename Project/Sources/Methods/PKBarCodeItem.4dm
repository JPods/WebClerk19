//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/28/14, 16:56:52
// ----------------------------------------------------
// Method: PKBarCodeItem
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	//Method: PKBarCodeItem
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//  ### jwm ### 20140205_0915 added ability to pass parameters
// ### jwm ### 20141023_2054 added parameter for OrderLines uniqueID

C_REAL:C285($1)  // Quantity
C_TEXT:C284($2)  // ItemNum
C_LONGINT:C283($3; $UniqueID)  //uniqueID  // ### jwm ### 20141023_2054

$w:=0
$showThisLine:=0
$lastInstance:=0
$insertSelect:=0
iLoReal3:=0
iLoReal4:=0
$UniqueID:=0

C_TEXT:C284(<>vBarCodeQtyItemDelim)
<>vBarCodeQtyItemDelim:=" "
$qtyBarCode:=0
pPartNum:=vsBarCdFld
If (<>vBarCodeQtyItemDelim#"")
	C_LONGINT:C283($p)
	$p:=Position:C15(<>vBarCodeQtyItemDelim; vsBarCdFld)
	If ($p>0)
		pPartNum:=Substring:C12(vsBarCdFld; $p+1)
		$qtyBarCode:=Num:C11(Substring:C12(vsBarCdFld; 1; $p-1))
	End if 
End if 

// EDI Process passes parameters
If (Count parameters:C259>1)
	$qtyBarCode:=$1
	pPartNum:=$2
	If (Count parameters:C259>2)
		$UniqueID:=$3
	End if 
End if 

QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
If (Records in selection:C76([Item:4])=1)
	//pPartNum:=vsBarCdFld
Else 
	QUERY:C277([Item:4]; [Item:4]barCode:34=pPartNum)
	If (Records in selection:C76([Item:4])=1)
		pPartNum:=[Item:4]itemNum:1
	Else 
		QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=pPartNum)
		If (Records in selection:C76([Item:4])=1)
			pPartNum:=[Item:4]itemNum:1
		Else 
			QUERY:C277([Item:4]; [Item:4]ean:82=pPartNum)
			If (Records in selection:C76([Item:4])=1)
				pPartNum:=[Item:4]itemNum:1
			Else 
				iLoText1:="ItemNum, Barcode, MfgItemNum not found"
			End if 
		End if 
	End if 
End if 
C_LONGINT:C283(viStopShip)
viStopShip:=Num:C11([Item:4]backOrder:24)
// ### jwm ### 20180506_2128
vrWeightAverage:=[Item:4]weightAverage:8
vrQtyBundleSell:=[Item:4]qtyBundleSell:79
vrQtyBulk:=[Item:4]qtyBulk:118
srItem:=[Item:4]itemNum:1
UNLOAD RECORD:C212([Item:4])

//### jwm ### 20120106_1036 case statement is New method for handling StopShip / Backorder Items

Case of 
		// ### jwm ### 20141023_2127 new case if unique ID passed in used for EDI and Scripts
	: ((pPartNum#"") & (viStopShip=0) & ($uniqueID>0))  //Item found is not on StopShip / Backorder
		ARRAY LONGINT:C221(aoLnSelect; 0)
		$w:=0
		$w:=Find in array:C230(aoUniqueID; $uniqueID)
		If ($w>0)
			If (aOQtyBL{$w}>0)
				BEEP:C151
				APPEND TO ARRAY:C911(aoLnSelect; $w)
				$showThisLine:=$w
				$lastInstance:=$w
				iLoReal3:=aOQtyBL{$w}
				iLoReal4:=Round:C94(aOUnitWt{$w}*aOQtyBL{$w}; 1)
				srItem:=aOItemNum{$w}
				srItemAltNum:=aOAltItem{$w}
				srItemDscrp:=aODescpt{$w}
				If (eOrdList>0)
					//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
					// -- AL_SetSelect(eOrdList; aoLnSelect)
					// -- AL_SetScroll(eOrdList; $w; viHorz)
				End if 
			Else   //(aOQtyBL{$w}<=0)
				$lastInstance:=$w+1
			End if 
		Else 
			If (<>barcodeErrorSound#"")
				PLAY:C290(<>barcodeErrorSound)
			Else 
				BEEP:C151
				BEEP:C151
				BEEP:C151
			End if 
			If ($lastInstance=0)
				errorComment:="OrderLine NOT on This Order"+"\r"+"\r"+"Barcode: "+vsBarCdFld
			Else 
				errorComment:="FULLY SHIPPED"+"\r"+"\r"+"Barcode: "+vsBarCdFld
			End if 
			PKAlertWindow
		End if 
		
		If ($showThisLine>0)  //  
			If ($qtyBarCode>0)
				PKLineIntoBox(-1; $qtyBarCode)
			Else 
				PKLineIntoBox(0)
			End if 
			doSearch:=0
		End if 
		
	: ((pPartNum#"") & (viStopShip=0))  //Item found is not on StopShip / Backorder
		
		ARRAY LONGINT:C221(aoLnSelect; 0)
		$w:=0
		$lastInstance:=0
		Repeat 
			$w:=Find in array:C230(aOItemNum; pPartNum; $lastInstance)
			If ($w>0)
				If (aOQtyBL{$w}>0)
					BEEP:C151
					$insertSelect:=Size of array:C274(aoLnSelect)+1
					INSERT IN ARRAY:C227(aoLnSelect; $insertSelect; 1)
					aoLnSelect{$insertSelect}:=$w
					$showThisLine:=$w
					iLoReal3:=aOQtyBL{$w}
					iLoReal4:=Round:C94(aOUnitWt{$w}*aOQtyBL{$w}; 1)
					srItem:=aOItemNum{$w}
					srItemAltNum:=aOAltItem{$w}
					srItemDscrp:=aODescpt{$w}
					If (eOrdList>0)
						//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
						// -- AL_SetSelect(eOrdList; aoLnSelect)
						// -- AL_SetScroll(eOrdList; $w; viHorz)
					End if 
				Else   //(aOQtyBL{$w}<=0)
					$lastInstance:=$w+1
				End if 
			Else 
				If (<>barcodeErrorSound#"")
					PLAY:C290(<>barcodeErrorSound)
				Else 
					BEEP:C151
					BEEP:C151
					BEEP:C151
				End if 
				If ($lastInstance=0)
					errorComment:="Item NOT on This Order"+"\r"+"\r"+"Barcode: "+vsBarCdFld
				Else 
					errorComment:="FULLY SHIPPED"+"\r"+"\r"+"Barcode: "+vsBarCdFld
				End if 
				PKAlertWindow
			End if 
		Until (($w<1) | ($showThisLine#0))
		
		
		If (False:C215)  //(eOrdList>0)
			//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
			// -- AL_SetSelect(eOrdList; aoLnSelect)
			// -- AL_SetScroll(eOrdList; $w; 1)
		End if 
		
		// Manual Qty Default    // ### jwm ### 20180312_1026
		
		If ($w>0)  // ### jwm ### 20180507_0933 check this logic for borcodes with qty
			If (viScanByAction=3)
				If (PKNo_ScanPack)
					PKQtyManual
				End if 
			Else 
				If ($showThisLine>0)  //  
					If ($qtyBarCode>0)
						PKLineIntoBox(-1; $qtyBarCode)
					Else 
						PKLineIntoBox(0)
					End if 
					doSearch:=0
				End if 
			End if 
		End if 
		
		
	: ((pPartNum#"") & (viStopShip=1))  //Item Found is on StopShip / Backorder
		If (<>barcodeErrorSound#"")
			PLAY:C290(<>barcodeErrorSound)
		Else 
			BEEP:C151
			BEEP:C151
			BEEP:C151
		End if 
		<>pkScaleComment:=pPartNum+" on STOPSHIP"
		errorComment:="Item on StopShip"+"\r"+"\r"+"Item Number: "+pPartNum
		PKAlertWindow
	Else 
		If (<>barcodeErrorSound#"")
			PLAY:C290(<>barcodeErrorSound)
		Else 
			BEEP:C151
			BEEP:C151
			BEEP:C151
		End if 
		errorComment:="Empty Barcode"+"\r"+"\r"+"Barcode: "+vsBarCdFld
		PKAlertWindow
End case 

//### jwm ### 20120106_1038 old method no longer being used

If (False:C215)
	//TRACE
	If ((pPartNum#"") & (viStopShip=0))
		ARRAY LONGINT:C221(aoLnSelect; 0)
		$w:=0
		$lastInstance:=0
		Repeat 
			$w:=Find in array:C230(aOItemNum; pPartNum; $lastInstance)
			If ($w>0)
				If (aOQtyBL{$w}>0)
					BEEP:C151
					$insertSelect:=Size of array:C274(aoLnSelect)+1
					INSERT IN ARRAY:C227(aoLnSelect; $insertSelect; 1)
					aoLnSelect{$insertSelect}:=$w
					$showThisLine:=$w
					iLoReal3:=aOQtyBL{$w}
					iLoReal4:=Round:C94(aOUnitWt{$w}*aOQtyBL{$w}; 1)
					srItem:=aOItemNum{$w}
					srItemAltNum:=aOAltItem{$w}
					srItemDscrp:=aODescpt{$w}
					If (eOrdList>0)
						//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
						// -- AL_SetSelect(eOrdList; aoLnSelect)
						// -- AL_SetScroll(eOrdList; $w; viHorz)
					End if 
				Else   //(aOQtyBL{$w}<=0)
					$lastInstance:=$w+1
				End if 
			Else 
				If (<>barcodeErrorSound#"")
					PLAY:C290(<>barcodeErrorSound)
				Else 
					BEEP:C151
					BEEP:C151
					BEEP:C151
				End if 
				If ($lastInstance=0)
					errorComment:="Item NOT on This Order"+"\r"+"\r"+"Barcode: "+vsBarCdFld
				Else 
					errorComment:="FULLY SHIPPED"+"\r"+"\r"+"Barcode: "+vsBarCdFld
				End if 
				PKAlertWindow
			End if 
		Until (($w<1) | ($showThisLine#0))
		If (False:C215)  //(eOrdList>0)
			//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
			// -- AL_SetSelect(eOrdList; aoLnSelect)
			// -- AL_SetScroll(eOrdList; $w; 1)
		End if 
		If ($showThisLine>0)
			If ($qtyBarCode>0)
				PKLineIntoBox(-1; $qtyBarCode)
			Else 
				PKLineIntoBox(0)
			End if 
			doSearch:=0
		End if 
	Else 
		If (<>barcodeErrorSound#"")
			PLAY:C290(<>barcodeErrorSound)
		Else 
			BEEP:C151
			BEEP:C151
			BEEP:C151
		End if 
		errorComment:="Empty Barcode"+"\r"+"\r"+"Barcode: "+vsBarCdFld
		PKAlertWindow
	End if 
End if 
