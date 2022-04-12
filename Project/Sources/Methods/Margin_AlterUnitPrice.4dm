//%attributes = {"publishedWeb":true}
//Method: PM:  Margin_AlterUnitPrice
//Noah Dykoski   October 5, 2000 / 11:41 PM
C_REAL:C285($1; $NewPriceTotal)
$NewPriceTotal:=$1

C_REAL:C285($orginalPrice)
$orginalPrice:=0
C_LONGINT:C283($soa; $index)
$soa:=Size of array:C274(aItemLines)
If ($soa>0)
	$bySel:=True:C214
	For ($index; 1; $soa)
		$orginalPrice:=$orginalPrice+LI_CalcExtPrice(vi1; aItemLines{$index})
	End for 
Else 
	$bySel:=False:C215
	$soa:=Size of array:C274(aQtyOnHand)
	For ($index; 1; $soa)
		$orginalPrice:=$orginalPrice+LI_CalcExtPrice(vi1; $index)
	End for 
End if 

If ($orginalPrice#0)
	
	C_REAL:C285($ApplyDiff; $orgTotal)
	$ApplyDiff:=$NewPriceTotal-$orginalPrice
	$ApplyDiff:=1+($ApplyDiff/$orginalPrice)  //Percentage change
	
	$orgTotal:=$NewPriceTotal
	vR1:=0
	C_LONGINT:C283($last)
	$last:=$soa
	C_BOOLEAN:C305($NotDone)
	$NotDone:=True:C214
	
	If ($bySel)
		For ($index; 1; $soa)
			aQtyOnHand{aItemLines{$index}}:=LI_CalcDiscountedUnitPrice(vi1; aItemLines{$index})*$ApplyDiff
			vR1:=vR1+LI_CalcExtPrice(vi1; aItemLines{$index}; aQtyOnHand{aItemLines{$index}})  //vi1 is the current table number
		End for 
		
		While ($NotDone)
			If (aPartQty{aItemLines{$last}}#0)
				$NotDone:=False:C215
			Else 
				$last:=$last-1
				If ($last<=0)
					$NotDone:=False:C215
				End if 
			End if 
		End while 
		If ($last>0)
			$unitMeasBy:=LI_GetUOMCountDivider(vi1; aItemLines{$last})
			$ApplyDiff:=(($orgTotal-vR1)*$unitMeasBy)/aPartQty{aItemLines{$last}}
			aQtyOnHand{aItemLines{$last}}:=aQtyOnHand{aItemLines{$last}}+$ApplyDiff
		End if 
		
		vR1:=0
		For ($index; 1; $soa)
			vR1:=vR1+LI_CalcExtPrice(vi1; aItemLines{$index}; aQtyOnHand{aItemLines{$index}})  //vi1 is the current table number
		End for 
	Else 
		For ($index; 1; $soa)
			aQtyOnHand{$index}:=LI_CalcDiscountedUnitPrice(vi1; $index)*$ApplyDiff
			vR1:=vR1+LI_CalcExtPrice(vi1; $index; aQtyOnHand{$index})  //vi1 is the current table number
		End for 
		
		While ($NotDone)
			If (aPartQty{$last}#0)
				$NotDone:=False:C215
			Else 
				$last:=$last-1
				If ($last<=0)
					$NotDone:=False:C215
				End if 
			End if 
		End while 
		If ($last>0)
			$unitMeasBy:=LI_GetUOMCountDivider(vi1; $last)
			$ApplyDiff:=(($orgTotal-vR1)*$unitMeasBy)/aPartQty{$last}
			aQtyOnHand{$last}:=aQtyOnHand{$last}+$ApplyDiff
		End if 
		
		vR1:=0
		For ($index; 1; $soa)
			vR1:=vR1+LI_CalcExtPrice(vi1; $index; aQtyOnHand{$index})  //vi1 is the current table number
		End for 
	End if 
	Margin_SumSelectedLines(->vR1; ->vR2; ->vR3; ->vR4)
	$soa:=Size of array:C274(aQtyOnHand)
	For ($index; 1; $soa)
		aQtyOrd{$index}:=Margin4Price(aQtyOnHand{$index}; aCosts{$index})
	End for 
	
Else 
	ALERT:C41("Sorry, This only works if the orginal total price was non-zero.  Adjust a price "+"outside and try again.")
End if 

