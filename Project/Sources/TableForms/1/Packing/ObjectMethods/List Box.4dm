C_LONGINT:C283($error; $i; $k)
Case of 
		//  : (Size of array(aoLineAction)=0)//drop out if no arrays
		//  : (ALProEvt=0)
	: (ALProEvt=1)  // single click
		//TRACE
		ARRAY LONGINT:C221(aoLnSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eOrdList; aoLnSelect)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274(aoLnSelect)
		//TRACE
		If ($k>0)
			$imagePath:=""
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{aoLnSelect{1}})
			If (Records in selection:C76([Item:4])=1)
				srItem:=[Item:4]itemNum:1
				srItemAltNum:=aOAltItem{aoLnSelect{1}}
				srItemDscrp:=[Item:4]description:7
				// ### jwm ### 20180506_2128
				vrWeightAverage:=[Item:4]weightAverage:8
				vrQtyBundleSell:=[Item:4]qtyBundleSell:79
				vrQtyBulk:=[Item:4]qtyBulk:118
				Item_GetSpec
				ImageGetPict
				UNLOAD RECORD:C212([Item:4])
				UNLOAD RECORD:C212([ItemSpec:31])
			End if 
			$packQty:=aOQtyBL{aoLnSelect{1}}-aOQtyPack{aoLnSelect{1}}
			iLoReal1:=$packQty
			iLoReal2:=Round:C94($packQty*aOUnitWt{aoLnSelect{1}}; viWtPrecision)
			<>vrWeightScale:=0
			<>vrWeightProduct:=0
			READ ONLY:C145([Item:4])
			// TRACE
			Case of 
				: (viScanByAction=1)
					iLoReal3:=Num:C11($packQty>0)
					iLoReal4:=Round:C94(iLoReal3*aOUnitWt{aoLnSelect{1}}; viWtPrecision)
				Else 
					iLoReal3:=$packQty
					iLoReal4:=Round:C94(iLoReal3*aOUnitWt{aoLnSelect{1}}; viWtPrecision)
			End case 
			
		End if 
		//  GOTO AREA(pQtyOrd)
	: (ALProEvt=2)
		TRACE:C157
		////  CHOPPED  $error:=AL_GetSelect (eOrdList;aRayLines)
		//COPY ARRAY(aRayLines;aOrdLnSel)
		//aoLineAction:=aRayLines{1}
		////  TRACE
		//KeyModifierCurrent 
		//If (OptKey=1)
		//List_OptDbClik (->aOItemNum{aoLineAction})
		//Else 
		//OrdLnDetails 
		//End if 
		//GOTO AREA(pQtyOrd)
		//
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All    
		AL_CmdAll(->aoLineAction; ->aRayLines)
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged
		If (False:C215)  // no saving of line changes
			For ($i; 1; Size of array:C274(aOSeq))
				aOSeq{$i}:=$i
				If (aoLineAction{$i}>-1)
					aoLineAction{$i}:=-2000
				End if 
			End for 
			
			[Order:3]idNum:2:=[Order:3]idNum:2  //force modified record to true
			vMod:=True:C214
		End if 
		//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
ALProEvt:=0
C_LONGINT:C283($error)