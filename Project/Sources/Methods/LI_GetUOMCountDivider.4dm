//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/24/10, 21:47:28
// ----------------------------------------------------
// Method: LI_GetUOMCountDivider
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_REAL:C285($0)  //Unit Measure By
C_LONGINT:C283($1; $TableNum)
$TableNum:=$1
C_LONGINT:C283($2; $LIArrayIndex)
$LIArrayIndex:=$2

Case of 
	: ($TableNum=Table:C252(->[Proposal:42]))
		$0:=1
		If (aPUnitMeas{$LIArrayIndex}#"")
			If (aPUnitMeas{$LIArrayIndex}[[1]]="*")
				//Jan 11, 1997
				$0:=Item_PricePer(->aPUnitMeas{$LIArrayIndex})
			End if 
		End if 
	: ($TableNum=Table:C252(->[Order:3]))
		$0:=1
		If (aOUnitMeas{$LIArrayIndex}#"")
			If (aOUnitMeas{$LIArrayIndex}[[1]]="*")
				//Jan 11, 1997
				$0:=Item_PricePer(->aOUnitMeas{$LIArrayIndex})
			End if 
		End if 
	: ($TableNum=Table:C252(->[Invoice:26]))
		$0:=1
		If (aiUnitMeas{$LIArrayIndex}#"")
			If (aiUnitMeas{$LIArrayIndex}[[1]]="*")
				//Jan 11, 1997
				$0:=Item_PricePer(->aiUnitMeas{$LIArrayIndex})
			End if 
		End if 
End case 