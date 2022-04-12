//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: txt_MaxLength  
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 
C_TEXT:C284($1; $0)
C_LONGINT:C283($2)
If ($2>0)
	$0:=Substring:C12($1; 1; $2)
Else 
	$0:=$1
End if 