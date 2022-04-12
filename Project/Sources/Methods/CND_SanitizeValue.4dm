//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/16/20, 10:28:07
// ----------------------------------------------------
// Method: CND_ParseValue
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0; $1; $voCondition)
$voCondition:=$1

C_LONGINT:C283($2; $viFieldType)
$viFieldType:=$2



// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** /

Case of 
	: (($viFieldType=Is alpha field:K8:1) | ($viFieldType=Is text:K8:3) | ($viFieldType=Is string var:K8:2))
		$voCondition.value:=String:C10($voCondition.value)
	: ($viFieldType=Is date:K8:7)
		If (OB Get type:C1230($voCondition; "value")=Is text:K8:3)
			$voCondition.value:=Date_ImportFromString($voCondition.value)
		Else 
			$voCondition.value:=Date:C102($voCondition.value)
		End if 
	: ($viFieldType=Is time:K8:8)
		$voCondition.value:=Time:C179($voCondition.value)
	: (($viFieldType=_o_Is float:K8:26) | ($viFieldType=Is real:K8:4) | ($viFieldType=Is integer:K8:5) | ($viFieldType=Is longint:K8:6))
		If (Position:C15("DT"; $voCondition.fieldName)=1)
			$voCondition.value:=DT_ImportFromString(String:C10($voCondition.value))
		Else 
			$voCondition.value:=Num:C11($voCondition.value)
		End if 
	: ($viFieldType=Is boolean:K8:9)
		If (($voCondition.value="1") | ($voCondition.value="true") | ($voCondition.value="yes"))
			$voCondition.value:=True:C214
		Else 
			$voCondition.value:=False:C215
		End if 
End case 

// ******************************************************************************************** //
// ** RETURN THE CONDITIONS STRING ************************************************************ //
// ******************************************************************************************** //

$0:=$voCondition