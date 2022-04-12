//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: XMLWriteOut
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_TEXT:C284($0; $1; $2; $3; $theParameters; $4)
$theParameters:=""
If ($3#"")
	$theParameters:=" "+$3
End if 
If (($4="skip") & ($2=""))
	$0:=""
Else 
	$0:="<"+$1+$theParameters+">"+$2+"</"+$1+">"+"\r"
End if 