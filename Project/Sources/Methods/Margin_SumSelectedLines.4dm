//%attributes = {"publishedWeb":true}
//Method: PM:  Margin_SumSelectedLines
//Noah Dykoski   October 6, 2000 / 4:29 PM
C_POINTER:C301($1; $rptrTotalPrice)
$rptrTotalPrice:=$1
C_POINTER:C301($2; $rptrTotalCost)
$rptrTotalCost:=$2
C_POINTER:C301($3; $rptrMarginDollars)
$rptrMarginDollars:=$3
C_POINTER:C301($4; $rptrMarginPercent)
$rptrMarginPercent:=$4

C_REAL:C285($totalPrice)
$totalPrice:=0
C_REAL:C285($totalCost)
$totalCost:=0
C_LONGINT:C283($soa; $index)
$soa:=Size of array:C274(aItemLines)
If ($soa>0)
	$bySel:=True:C214
	For ($index; 1; $soa)
		$totalPrice:=$totalPrice+LI_CalcExtPrice(vi1; aItemLines{$index}; aQtyOnHand{aItemLines{$index}})
		$totalCost:=$totalCost+LI_CalcExtCost(vi1; aItemLines{$index})
	End for 
Else 
	$bySel:=False:C215
	$soa:=Size of array:C274(aQtyOnHand)
	For ($index; 1; $soa)
		$totalPrice:=$totalPrice+LI_CalcExtPrice(vi1; $index; aQtyOnHand{$index})
		$totalCost:=$totalCost+LI_CalcExtCost(vi1; $index)
	End for 
End if 
$rptrTotalPrice->:=$totalPrice
$rptrTotalCost->:=$totalCost
MarginCalc($rptrTotalPrice; $rptrTotalCost; $rptrMarginDollars; $rptrMarginPercent)