//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Method: WccQueryFieldFromText
	//Date: 07/01/02
	//Who: Bill
	//Description: Method: Wcc_FieldFromText
	//Using Type and constants
End if 
C_POINTER:C301($1; $ptTable)
C_LONGINT:C283($3; $0)
$ptTable:=Table:C252(Table:C252($1))
C_TEXT:C284($2)
C_LONGINT:C283($theType)
$theType:=Type:C295($1->)
$0:=0
Case of 
	: (($theType=Is alpha field:K8:1) | ($theType=Is text:K8:3) | ($theType=Is string var:K8:2))  //string
		If ($3>0)
			QUERY:C277($ptTable->; $1->=$2)
		Else 
			QUERY:C277($ptTable->;  & $1->=$2)
		End if 
		$0:=1
	: (($theType=Is integer:K8:5) | ($theType=Is longint:K8:6) | ($theType=Is real:K8:4))  //Numbers
		If ($3>0)
			QUERY:C277($ptTable->; $1->=Num:C11($2))
		Else 
			QUERY:C277($ptTable->;  & $1->=Num:C11($2))
		End if 
		$0:=1
	: ($theType=Is time:K8:8)  //time    
		If ($3>0)
			QUERY:C277($ptTable->; $1->=Time:C179($2))
		Else 
			QUERY:C277($ptTable->;  & $1->=Time:C179($2))
		End if 
		$0:=1
	: ($theType=Is date:K8:7)  //date
		If ($3>0)
			QUERY:C277($ptTable->; $1->=Date:C102($2))
		Else 
			QUERY:C277($ptTable->;  & $1->=Date:C102($2))
		End if 
		$0:=1
	: ($theType=Is boolean:K8:9)  //boolean
		If (($2="t@") | ($2="y@") | ($2="1"))
			If ($3>0)
				QUERY:C277($ptTable->; $1->=True:C214)
			Else 
				QUERY:C277($ptTable->;  & $1->=True:C214)
			End if 
		Else 
			If ($3>0)
				QUERY:C277($ptTable->; $1->=False:C215)
			Else 
				QUERY:C277($ptTable->;  & $1->=False:C215)
			End if 
		End if 
		$0:=1
End case 