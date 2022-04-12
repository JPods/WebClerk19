//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:06:38
// ----------------------------------------------------
// Method: PKLineIntoBox
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141210_2327 exclude tare weight if no reading from scale
// ### jwm ### 20141211_0919 gloabal change <>vrWeightdeviation to <>vrWeightDeviation


If (Size of array:C274(aoLnSelect)<1)
	<>pkScaleComment:="Item not in this Order"
	PKAlertWindow
Else 
	OBJECT SET ENABLED:C1123(b3; False:C215)
	READ ONLY:C145([Item:4])
	C_LONGINT:C283($w; $scanAction; $1)
	C_REAL:C285($2; $qtyPack)
	
	If (Count parameters:C259=2)
		$scanAction:=$1
		$qtyPack:=$2
	Else 
		$scanAction:=viScanByAction
		$qtyPack:=iLoReal3
	End if 
	$w:=aoLnSelect{1}
	//$w:=Find in array(aoUniqueID;vlLineUniqueID)
	$wPack:=Find in array:C230(aLiLineID; aoUniqueID{aoLnSelect{1}})  //find if
	//
	Case of 
		: ($scanAction=-1)
			//   iLoReal3:=$qtyPack
		: ($scanAction=3)
			//   iLoReal3:=$qtyPack
		: ($scanAction<2)  //add by scan count
			If (aOQtyBL{$w}>0)
				$qtyPack:=1
			Else 
				$qtyPack:=aOQtyBL{$w}
			End if 
		: ($scanAction=2)  //add by current backlog
			$qtyPack:=aOQtyBL{$w}
		: ($scanAction>3)  //add by current backlog
			Case of 
				: ((iLoReal3>0) & (iLoReal3<aOQtyBL{$w}))
					//accept it as is          
				: (iLoReal3=0) & (aOQtyBL{$w}>=1)  //set qty to one
					$qtyPack:=1
				Else 
					$qtyPack:=aOQtyBL{$w}
			End case 
			//leave value for iLoReal3 as it is
	End case 
	
	iLoReal3:=$qtyPack
	Case of 
		: (((aOQtyBL{aoLnSelect{1}}<=0) & (aOQtyOrder{aoLnSelect{1}}>0)) | ((aOQtyBL{aoLnSelect{1}}>=0) & (aOQtyOrder{aoLnSelect{1}}<0)))
			<>pkScaleComment:="Item Fully Packed on this Order"
			PKAlertWindow
			
		: (aOQtyBL{aoLnSelect{1}}<$qtyPack)  // Qty Pack is greater than Qty Backlog  // ### jwm ### 20180312_1119
			<>pkScaleComment:="Qty "+String:C10($qtyPack)+" is > BLQ "+String:C10(aOQtyBL{aoLnSelect{1}})
			PKAlertWindow
			
		Else 
			//If ($w=0)(2103578301
			C_TEXT:C284(vResponse)
			If (vResponse#"")
				[Order:3]commentProcess:12:="Packing "+vResponse+", "+Current user:C182+", "+String:C10(Current date:C33)+", "+String:C10(Current time:C178)+", "+String:C10($qtyPack)+", "+aOItemNum{aoLnSelect{1}}+"\r"+[Order:3]commentProcess:12
				vResponse:=""
			End if 
			//<>pkScaleComment:="Item bad something"
			//Else 
			
			aOQtyPack{$w}:=aOQtyPack{$w}+$qtyPack
			aOQtyBL{$w}:=aOQtyBL{$w}-$qtyPack
			//
			$packQty:=$qtyPack
			iLoReal4:=Round:C94($qtyPack*aOUnitWt{$w}; viWtPrecision)
			//                
			If ($wPack<1)  //not yet in this box, add the line if not
				$wPack:=1
				LT_FillArrayLoadItems(-3; 1; 1)  //in box array
				aLiLoadTagID{1}:=-3  //new line
				aLiDocID{1}:=srSO
				aLiTableType{1}:=Table:C252(->[Order:3])
				aLiLineID{1}:=aoUniqueID{aoLnSelect{1}}
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{aoLnSelect{1}})
				If ($qtyPack>0)
					aLiHazardClass{$wPack}:=[Item:4]hazardClassification:105
					aLiUnitWt{$wPack}:=aOUnitWt{aoLnSelect{1}}
					aLiValue{$wPack}:=aODscntUP{aoLnSelect{1}}
				End if 
				aLiItemNum{$wPack}:=aOItemNum{aoLnSelect{1}}
				aLiItemDescription{$wPack}:=aODescpt{aoLnSelect{1}}
				UNLOAD RECORD:C212([Item:4])
			End if 
			//
			<>itemWt:=$qtyPack*aOUnitWt{aoLnSelect{1}}
			<>scanScaleItemWt:=<>vrWeightScale+<>itemWt
			//
			aLiQty{$wPack}:=aLiQty{$wPack}+$qtyPack  //count to be added, based on value of 
			aLiExtendedWt{$wPack}:=Round:C94(aLiUnitWt{$wPack}*aLiQty{$wPack}; viWtPrecision)
			
			aLiTagGroup{$wPack}:=1
			vlLineUniqueID:=aLiLineID{$wPack}
			iLoReal2:=aLiExtendedWt{$wPack}
			iLoReal1:=aLiQty{$wPack}
			
			//<>vrWeightProduct:=iLoReal3*iLoReal4
			// ### jwm ### 20141210_2327 exclude tare weight if no reading from scale
			// test this Is Deviation only a display value?
			// gloabal change <>vrWeightdiviation to <>vrWeightDeviation
			If (<>vrWeightTare=-77777)
				<>vrWeightDeviation:=<>vrWeightProduct-<>vrWeightScale
			Else 
				<>vrWeightDeviation:=<>vrWeightProduct+<>vrWeightTare-<>vrWeightScale
			End if 
	End case 
	//End if 
	
	ARRAY LONGINT:C221(aLiLoadItemSelect; 1)
	aLiLoadItemSelect{1}:=$wPack
	
	If (eLoadList>0)
		//  CHOPPED  $error:=AL_GetSelect(eLoadList; aoLnSelect)
		//  CHOPPED  AL_GetScroll(eLoadList; viVert; viHorz)
		//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
		// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)
		// -- AL_SetScroll(eLoadList; viVert; viHorz)
		
		//  CHOPPED  $error:=AL_GetSelect(eOrdList; aoLnSelect)
		//  CHOPPED  AL_GetScroll(eOrdList; viVert; viHorz)
		//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
		// -- AL_SetSelect(eOrdList; aoLnSelect)
		// -- AL_SetScroll(eOrdList; viVert; viHorz)
		PKSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101014
	End if 
	READ WRITE:C146([Item:4])
End if 
UNLOAD RECORD:C212([Item:4])
