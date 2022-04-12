$cntLines:=(Size of array:C274(aPPLnSelect))
If ($cntLines>0)
	For ($incLine; 1; $cntLines)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=aPItemNum{aPPLnSelect{$incLine}})
		pPartNum:=[Item:4]itemNum:1
		pDescript:=[Item:4]description:7
		pUnitCost:=[Item:4]costAverage:13
		[Item:4]qtySaleDefault:15:=aPQtyOrder{aPPLnSelect{$incLine}}
		PpLnAdd((Size of array:C274(aPLineAction)+1); 1; True:C214)
	End for 
	//
	//  CHOPPED  AL_GetScroll(ePropList; viVert; viHorz)
	viVert:=aPLineAction
	//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
	// -- AL_SetSelect(ePropList; aPPLnSelect)
	// -- AL_SetScroll(ePropList; viVert; viHorz)
	//
End if 
ItemSetButtons((Size of array:C274(aPLineAction)>0); True:C214)