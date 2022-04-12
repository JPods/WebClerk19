// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/14/15, 15:16:04
// ----------------------------------------------------
// Method: [Control].Packing.Variable4169
// Description: aDunList
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150114_1515 made dunnage drop down visible and set method to TRUE


If (True:C214)  // ### jwm ### 20150114_1515
	If (aDunList>1)
		<>pkScaleComment:=""  //clear any existing error message  
		GOTO RECORD:C242([Item:4]; aDunItemRec{aDunList})
		$wPack:=Find in array:C230(aLiItemNum; [Item:4]itemNum:1)
		If ($wPack<1)
			$wPack:=1
			LT_FillArrayLoadItems(-3; 1; 1)  //in box array
			aLiLoadTagID{1}:=-3  //new line
			aLiDocID{1}:=srSO
			aLiTableType{1}:=Table:C252(->[Order:3])
			aLiLineID{1}:=-18  //not part of an order or invoice
			aLiInvoiceNum{1}:=-18
			//
			aLiHazardClass{$wPack}:=[Item:4]hazardClassification:105
			aLiUnitWt{$wPack}:=[Item:4]weightAverage:8
			aLiValue{$wPack}:=[Item:4]costAverage:13
			aLiItemNum{$wPack}:=[Item:4]itemNum:1
			aLiItemDescription{$wPack}:=[Item:4]description:7
		End if 
		UNLOAD RECORD:C212([Item:4])
		aLiQty{$wPack}:=aLiQty{$wPack}+1  //count to be added, based on value of 
		aLiExtendedWt{$wPack}:=Round:C94(aLiUnitWt{$wPack}*aLiQty{$wPack}; viWtPrecision)
		//
		iLoReal3:=iLoReal3+1
		iLoReal4:=Round:C94(iLoReal3*aLiUnitWt{$wPack}; viWtPrecision)
		//
		aLiTagGroup{$wPack}:=1
		vlLineUniqueID:=aLiLineID{$wPack}
		iLoReal2:=aLiExtendedWt{$wPack}
		iLoReal1:=aLiQty{$wPack}
		//
		ARRAY LONGINT:C221(aLiLoadItemSelect; 1)
		aLiLoadItemSelect{1}:=$wPack
		//
		//  CHOPPED  $error:=AL_GetSelect(eLoadList; aoLnSelect)
		//  CHOPPED  AL_GetScroll(eLoadList; viVert; viHorz)
		//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
		// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)
		// -- AL_SetScroll(eLoadList; viVert; viHorz)
		//
	End if 
	aDunList:=1
End if 