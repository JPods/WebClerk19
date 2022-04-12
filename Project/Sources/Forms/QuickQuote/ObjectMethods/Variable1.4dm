// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/11/08, 14:49:32
// ----------------------------------------------------
// Method: Object Method: <>rQQAddQty
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aLsSrRec)

For ($i; 1; $k)
	GOTO RECORD:C242([Item:4]; aLsSrRec{$i})
	
	pQtyOrd:=<>rQQAddQty  //variables required based on web pricing
	pvTypeSale:=ItemChoice_TypeSaleSel  //variables required based on web pricing
	ItemKeyPathVariables  //variables required based on web pricing
	
	//DscntSpecialClr (ItemChoice_TypeSaleSel)
	//DscntSetPrice (ItemChoice_TypeSaleSel)//sets vSpclDscn (global disc) or the array aDscnPC (item disc)
	$discPercent:=pDiscnt
	//$fia:=Find in array(aDsctItem;[Item]ItemNum)
	//If ($fia>0)
	//$discPercent:=$discPercent+aDscnPC{$fia}
	//aLsPrice{$i}:=aBasePrice{$fia}
	//End if 
	$discntPrc:=DiscountApply(aLsPrice{$i}; $discPercent; 10)
	$discntPrc:=Round:C94($discntPrc; <>tcDecimalUP+4)
	//$priceDisc:=(aLsPrice{$i})-((aLsPrice{$i})*($discPercent/100))    
	aLsDiscount{$i}:=$discPercent
	aLsDiscountPrice{$i}:=Round:C94($discntPrc; <>tcDecimalTt)
	aLSMargin{$i}:=Margin4Price(aLsPrice{$i}; aLsCost{$i})
End for 
//// -- AL_SetRowColor (eQuickQuote;0;"Black";0;"white";0)
//  --  CHOPPED  AL_UpdateArrays(eQuickQuote; -2)
$setLine:=aLsItemNum
// -- AL_SetLine(eQuickQuote; $setLine)


UNLOAD RECORD:C212([Item:4])
If ($k>1)
	UNLOAD RECORD:C212([ItemSpec:31])
End if 