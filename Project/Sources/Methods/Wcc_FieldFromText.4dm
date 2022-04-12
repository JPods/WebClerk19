//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Wcc_FieldFromText
	//Date: 07/01/02
	//Who: Bill
	//Description: Method: Wcc_FieldFromText
	
	//Associated, does the opposite 
	Txt_Return2String
	
End if 
C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($theType)
$theType:=Type:C295($1->)
Case of 
	: (($theType=Is alpha field:K8:1) | ($theType=Is text:K8:3) | ($theType=Is string var:K8:2))  //string
		$1->:=$2
	: (($theType=Is integer:K8:5) | ($theType=Is longint:K8:6) | ($theType=Is real:K8:4))  //Numbers
		$1->:=Num:C11($2)
	: ($theType=Is time:K8:8)  //time    
		$pointer->:=Time:C179($2)
	: ($theType=Is date:K8:7)  //date
		$1->:=Date:C102($2)
	: ($theType=Is boolean:K8:9)  //boolean
		If (($2="t@") | ($2="y@") | ($2="1"))
			$1->:=True:C214
		Else 
			$1->:=False:C215
		End if 
End case 