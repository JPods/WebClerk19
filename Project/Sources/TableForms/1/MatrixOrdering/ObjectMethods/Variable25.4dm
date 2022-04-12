If (False:C215)
	//Date: 03/13/02
	//Who: Dan Bentson, Arkware
	//Description: Added correct rounding
	
	//Date: 03/12/02
	//Who: Dan Bentson, Arkware
	//Description:Using discount base price for price
	
	//Date: 02/26/02
	//Who: Dan Bentson, Arkware
	//Description: replaced $2 with vUseBase
	//   restore row highlighted 3/1/02
	VERSION_960
End if 
//
vUseBase:=SetPricePoint(<>aTypeSale{<>aTypeSale})

C_TEXT:C284($temp)
C_LONGINT:C283($tempBase; $i; $k; $w)
If (<>aTypeSale=0)
	<>aTypeSale:=1
Else 
	C_BOOLEAN:C305($doSpecial)
	If (Size of array:C274(aLsDocType)#0)
		If (<>tcbManyType)
			$doSpecial:=(<>aTypeSaleRecordNum{<>aTypeSale}>0)
			If ($doSpecial)
				vDate1:=Current date:C33
				DscntSetPrice(<>aTypeSale{<>aTypeSale})
			End if 
		End if 
	End if 
	READ ONLY:C145([Item:4])
	//  CHOPPED  $error:=AL_GetSelect(eQuickQuote; aItemLines)
	// If (Size of array(aItemLines)=0)
	// INSERT ELEMENT(aItemLines;1;1)
	//aItemLines{1}:=1
	//End if 
	
	$k:=Size of array:C274(aLsItemNum)  // operate on all lines
	//  CHOPPED  AL_GetScroll(eQuickQuote; viVert; viHorz)
	
	C_LONGINT:C283($thePrec)
	$thePrec:=<>tcDecimalTt
	
	C_REAL:C285($discntPrc; $discPercent)
	C_TEXT:C284(ItemChoice_TypeSaleSel)
	C_LONGINT:C283($fia)
	For ($i; 1; $k)
		If (aLsSrRec{$i}>0)
			GOTO RECORD:C242([Item:4]; aLsSrRec{$i})
			//$w:=Find in array(aLsItemNum;[Item]ItemNum)
			If ($doSpecial)
				//If ($w>0)
				aLsPrice{$i}:=Round:C94(DiscountApply(aBasePrice{$i}; aDscnPC{$i}; 10); <>tcDecimalUP)
				aLSMargin{$i}:=Margin4Price(aLsPrice{$i}; aLsCost{$i})
				//Else 
				//aLsPrice{$i}:=Field(4;vUseBase)->
				//aLSMargin{$i}:=Margin4Price (aLsPrice{$i};aLsCost{$i})
				//End if 
			Else 
				aLsPrice{$i}:=Field:C253(4; vUseBase)->
				aLSMargin{$i}:=Margin4Price(aLsPrice{$i}; aLsCost{$i})
			End if 
			//If ($w>0)
			ItemChoice_TypeSaleSel:=(<>aTypeSale{<>aTypeSale})
			DscntSpecialClr(ItemChoice_TypeSaleSel)
			DscntSetPrice(ItemChoice_TypeSaleSel)  //sets vSpclDscn (global disc) or the array aDscnPC (item disc)
			$discPercent:=vSpclDscn
			$fia:=Find in array:C230(aDsctItem; [Item:4]itemNum:1)
			If ($fia>0)
				$discPercent:=$discPercent+aDscnPC{$fia}
				aLsPrice{$i}:=aBasePrice{$fia}
			End if 
			
			$discntPrc:=DiscountApply(aLsPrice{$i}; $discPercent; 10)
			$discntPrc:=Round:C94($discntPrc; <>tcDecimalUP+4)
			// $priceDisc:=(aLsPrice{$i})-((aLsPrice{$i})*($discPercent/100))
			aLsDiscount{$i}:=$discPercent
			aLsDiscountPrice{$i}:=Round:C94($discntPrc; $thePrec)
			//End if 
		End if 
	End for 
	READ WRITE:C146([Item:4])
	//  --  CHOPPED  AL_UpdateArrays(eQuickQuote; -2)
	If (Size of array:C274(aItemLines)>0)  //03/01/02 - restore selection
		// -- AL_SetSelect(eQuickQuote; aItemLines)
		// Modified by: William James (2013-09-09T00:00:00)
		If (Size of array:C274(aItemLines)>1)
			If (Size of array:C274(aLsSrRec)>=aItemLines{1})
				GOTO RECORD:C242([Item:4]; aLsSrRec{aItemLines{1}})
			End if 
		End if 
	End if 
	// -- AL_SetScroll(eQuickQuote; viVert; viHorz)
	
End if 