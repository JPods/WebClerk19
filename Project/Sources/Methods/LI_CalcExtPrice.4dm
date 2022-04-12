//%attributes = {"publishedWeb":true}
//Method: PM:  LI_CalcExtPrice
//Noah Dykoski   October 2, 2000 / 6:08 PM
C_REAL:C285($0)  //Extended Price
C_LONGINT:C283($1; $TableNum)
$TableNum:=$1
C_LONGINT:C283($2; $LIArrayIndex)
$LIArrayIndex:=$2
C_REAL:C285($3; $discntPrc)
If (Count parameters:C259>=3)
	$discntPrc:=$3
Else 
	$discntPrc:=LI_CalcDiscountedUnitPrice($TableNum; $LIArrayIndex)
End if 

C_LONGINT:C283($thePrec)
$thePrec:=LI_GetUnitPrecision($TableNum)
C_REAL:C285($unitMeasBy)
$unitMeasBy:=LI_GetUOMCountDivider($TableNum; $LIArrayIndex)
Case of 
	: ($TableNum=Table:C252(->[Proposal:42]))
		$0:=Round:C94((aPQtyOrder{$LIArrayIndex}*$discntPrc)/$unitMeasBy; $thePrec)
	: ($TableNum=Table:C252(->[Order:3]))
		If (aOLnCmplt{$LIArrayIndex}="")
			$0:=Round:C94((aOQtyOrder{$LIArrayIndex}/$unitMeasBy)*$discntPrc; $thePrec)
		Else 
			$0:=Round:C94((aOQtyShip{$LIArrayIndex}/$unitMeasBy)*$discntPrc; $thePrec)
		End if 
	: ($TableNum=Table:C252(->[Invoice:26]))
		$0:=Round:C94((aiQtyShip{$LIArrayIndex}/$unitMeasBy)*$discntPrc; $thePrec)
End case 