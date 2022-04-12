//%attributes = {"publishedWeb":true}
//Method: PM:  LI_CalcExtCost
//Noah Dykoski   October 2, 2000 / 6:08 PM
C_REAL:C285($0)  //Extended Cost
C_LONGINT:C283($1; $TableNum)
$TableNum:=$1
C_LONGINT:C283($2; $LIArrayIndex)
$LIArrayIndex:=$2
C_REAL:C285($3; $UnitCost)
If (Count parameters:C259>=3)
	$UnitCost:=$3
Else 
	Case of 
		: ($TableNum=Table:C252(->[Proposal:42]))
			$UnitCost:=aPUnitCost{$LIArrayIndex}
		: ($TableNum=Table:C252(->[Order:3]))
			$UnitCost:=aOUnitCost{$LIArrayIndex}
		: ($TableNum=Table:C252(->[Invoice:26]))
			$UnitCost:=aiUnitCost{$LIArrayIndex}
	End case 
End if 

C_LONGINT:C283($thePrec)
$thePrec:=LI_GetUnitPrecision($TableNum)
C_REAL:C285($unitMeasBy)
$unitMeasBy:=LI_GetUOMCountDivider($TableNum; $LIArrayIndex)
Case of 
	: ($TableNum=Table:C252(->[Proposal:42]))
		$0:=Round:C94(aPQtyOrder{$LIArrayIndex}*$UnitCost/$unitMeasBy; $thePrec)
	: ($TableNum=Table:C252(->[Order:3]))
		If (aOLnCmplt{$LIArrayIndex}="")
			$0:=Round:C94((aOQtyOrder{$LIArrayIndex}*$UnitCost/$unitMeasBy); $thePrec)
		Else 
			$0:=Round:C94((aOQtyShip{$LIArrayIndex}*$UnitCost/$unitMeasBy); $thePrec)
		End if 
	: ($TableNum=Table:C252(->[Invoice:26]))
		$0:=Round:C94((aiQtyShip{$LIArrayIndex}*$UnitCost/$unitMeasBy); $thePrec)
End case 