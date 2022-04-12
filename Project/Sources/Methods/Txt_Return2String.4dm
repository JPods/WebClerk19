//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/14/12, 12:00:17
// ----------------------------------------------------
// Method: Txt_Return2String
// Description
// 
//Associated, does the opposite 
Wcc_FieldFromText

//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1)
C_TEXT:C284($0)
C_LONGINT:C283($theType)
$theType:=Type:C295($1->)
Case of 
	: (($theType=Is alpha field:K8:1) | ($theType=Is text:K8:3))
		$0:=$1->
	: ($theType=Is real:K8:4)
		$0:=String:C10($1->)
	: ($theType=Is integer:K8:5)
		$0:=String:C10($1->)
	: ($theType=Is longint:K8:6)
		$0:=String:C10($1->)
	: ($theType=Is date:K8:7)
		$0:=String:C10($1->)
	: ($theType=Is time:K8:8)
		$0:=String:C10($1->)
End case 