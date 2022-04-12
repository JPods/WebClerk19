//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtilReturnMinValue
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1; $2; $0)
If ($1<$2)
	$0:=$1
Else 
	$0:=$2
End if 