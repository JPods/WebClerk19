//%attributes = {"publishedWeb":true}
//Method: PM:  LI_GetUnitPrice
//Noah Dykoski   October 8, 2000 / 4:18 PM
//get the current or orginal unit price
C_REAL:C285($0)  //Extended Price
C_LONGINT:C283($1; $TableNum)
$TableNum:=$1
C_LONGINT:C283($2; $LIArrayIndex)
$LIArrayIndex:=$2

Case of 
	: ($TableNum=Table:C252(->[Proposal:42]))
		$0:=aPUnitPrice{$LIArrayIndex}
	: ($TableNum=Table:C252(->[Order:3]))
		$0:=aOUnitPrice{$LIArrayIndex}
	: ($TableNum=Table:C252(->[Invoice:26]))
		$0:=aiUnitPrice{$LIArrayIndex}
End case 