//%attributes = {"publishedWeb":true}
//Method: PM:  LI_CalcDiscountedUnitPrice
//Noah Dykoski   February 16, 2001 / 1:25 PM
C_REAL:C285($0)  //Discounted Unit Price
C_LONGINT:C283($1; $TableNum)
$TableNum:=$1
C_LONGINT:C283($2; $LIArrayIndex)
$LIArrayIndex:=$2
C_REAL:C285($3; $UnitPrice)
If (Count parameters:C259>=3)
	$UnitPrice:=$3
Else 
	$UnitPrice:=LI_GetUnitPrice($TableNum; $LIArrayIndex)
End if 

Case of 
	: ($TableNum=Table:C252(->[Proposal:42]))
		$0:=DiscountApply($UnitPrice; aPDiscnt{$LIArrayIndex}; 10)
	: ($TableNum=Table:C252(->[Order:3]))
		$0:=DiscountApply($UnitPrice; aODiscnt{$LIArrayIndex}; 10)
	: ($TableNum=Table:C252(->[Invoice:26]))
		$0:=DiscountApply($UnitPrice; aiDiscnt{$LIArrayIndex}; 10)
End case 