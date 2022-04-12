//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtFillPriority
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_POINTER:C301($1)
C_TEXT:C284($2; $3)
C_LONGINT:C283($cntPara)
If (($2="") & ($3#""))
	$1->:=$2
Else 
	$1->:=$3
End if 