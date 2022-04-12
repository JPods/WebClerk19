//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtFillifNotEmpty
	//Date: 03/11/03
	//Who: Bill
	//Description: Fill pointer by Type if not empty
	//Very useful utility Type conversion
End if 
C_POINTER:C301($1)  //pointer to field, variable or array - $4 is the array element
C_TEXT:C284($2)  //value to enter if not empty or $overrides is not 1
C_LONGINT:C283($3; $overrides; $4)  //$overrides overrides empty avoidance;   $4 is an array element
$theType:=Type:C295($1->)
$overrides:=0
If (Count parameters:C259>2)
	$overrides:=$3
End if 
Case of 
	: (($theType=Is alpha field:K8:1) | ($theType=Is alpha field:K8:1))
		If (($2#"") | ($overrides=1))
			$1->:=$2
			If (Character code:C91($2)=34)  //a quote
				$1->:=Parse_UnWanted($1->)
			End if 
		End if 
	: ($theType=Is text:K8:3)
		If (($2#"") | ($overrides=1))
			$1->:=$2
		End if 
	: ($theType=Is boolean:K8:9)
		If (($2#"") | ($overrides=1))
			$1->:=(Num:C11($2)=1)
		End if 
	: ($theType=Is date:K8:7)
		If (($2#"") | ($overrides=1))
			$1->:=Date:C102($2)
		End if 
	: (($theType=Is real:K8:4) | ($theType=Is integer:K8:5) | ($theType=Is longint:K8:6))
		If (($2#"") | ($overrides=1))
			$1->:=Num:C11($2)
		End if 
	: ($theType=Is time:K8:8)
		If (($2#"") | ($overrides=1))
			$1->:=Time:C179($2)
		End if 
End case 