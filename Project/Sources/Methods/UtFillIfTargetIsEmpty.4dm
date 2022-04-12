//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/01/11, 18:15:18
// ----------------------------------------------------
// Method: UtFillIfTargetIsEmpty
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)

C_POINTER:C301($1)  //pointer to field, variable or array - $4 is the array element
C_TEXT:C284($2)  //value to enter if not empty or $3 is not 1
C_LONGINT:C283($3; $4)  //$3 overrides empty avoidance;   $4 is an array element
$theType:=Type:C295($1->)
Case of 
	: (($theType=Is alpha field:K8:1) | ($theType=Is alpha field:K8:1))
		If ($1->="")
			$1->:=$2
			$1->:=Parse_UnWanted($1->)
		End if 
	: ($theType=Is text:K8:3)
		If ($1->="")
			$1->:=$2
		End if 
	: ($theType=Is boolean:K8:9)
		If ($1->=False:C215)
			$1->:=((Num:C11($2)=1) | ($2="1@") | ($2="t@") | ($2="y@"))
		End if 
	: ($theType=Is date:K8:7)
		If ($1->=!00-00-00!)
			$1->:=Date:C102($2)
		End if 
	: (($theType=Is real:K8:4) | ($theType=Is integer:K8:5) | ($theType=Is longint:K8:6))
		If ($1->=0)
			$1->:=Num:C11($2)
		End if 
	: ($theType=Is time:K8:8)
		If ($1->=?00:00:00?)
			$1->:=Time:C179($2)
		End if 
End case 

