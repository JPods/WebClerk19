//%attributes = {"publishedWeb":true}
//Method: PM:  MarginCalc
//Noah Dykoski   October 6, 2000 / 4:33 PM
C_POINTER:C301($1; $rptrTotalPrice)
$rptrTotalPrice:=$1
C_POINTER:C301($2; $rptrTotalCost)
$rptrTotalCost:=$2
C_POINTER:C301($3; $rptrMarginDollars)
$rptrMarginDollars:=$3
C_POINTER:C301($4; $rptrMarginPercent)
$rptrMarginPercent:=$4

$rptrMarginDollars->:=$rptrTotalPrice->-$rptrTotalCost->
$rptrMarginPercent->:=Margin4Price($rptrTotalPrice->; $rptrTotalCost->)
