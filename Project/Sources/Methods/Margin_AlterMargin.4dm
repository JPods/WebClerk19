//%attributes = {"publishedWeb":true}
//Method: PM:  Margin_AlterMargin
//Noah Dykoski   October 5, 2000 / 11:41 PM
C_REAL:C285($1; $NewMargin)
$NewMargin:=$1

C_REAL:C285($ApplyDiff)
$ApplyDiff:=1/(1-($NewMargin/100))

vR1:=0
$soa:=Size of array:C274(aItemLines)
If ($soa>0)
	For ($index; 1; $soa)
		aQtyOnHand{aItemLines{$index}}:=aCosts{aItemLines{$index}}*$ApplyDiff
		vR1:=vR1+LI_CalcExtPrice(vi1; aItemLines{$index}; aQtyOnHand{aItemLines{$index}})  //vi1 is the current table number
	End for 
Else 
	$soa:=Size of array:C274(aQtyOnHand)
	For ($index; 1; $soa)
		aQtyOnHand{$index}:=aCosts{$index}*$ApplyDiff
		vR1:=vR1+LI_CalcExtPrice(vi1; $index; aQtyOnHand{$index})  //vi1 is the current table number
	End for 
End if 
MarginCalc(->vR1; ->vR2; ->vR3; ->vR4)
$soa:=Size of array:C274(aQtyOnHand)
For ($index; 1; $soa)
	aQtyOrd{$index}:=Margin4Price(aQtyOnHand{$index}; aCosts{$index})
End for 