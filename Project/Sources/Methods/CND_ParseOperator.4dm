//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/16/20, 10:28:07
// ----------------------------------------------------
// Method: CND_ParseOperator
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



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($viValueType)
C_BOOLEAN:C305($vbQueryOperatorNot)


// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** /

// LOAD DEFAULTS FOR OPERATOR IF NOT SPECIFIED

If (OB Is defined:C1231($voCondition; "operator")=False:C215)
	$voCondition.operator:="equals"
Else 
	If ($voCondition.operator="")
		$voCondition.operator:="equals"
	End if 
End if 

// GET FIELD POINTER AND TYPE

$viValueType:=OB Get type:C1230($voCondition; "value")

// CONVERT THE OPERATOR TO 4D OPERATOR SCRIPT

If (Position:C15("not"; $voCondition.operator)=1)
	$vbQueryOperatorNot:=True:C214
	$voCondition.operator:=Replace string:C233($voCondition.operator; "not "; "")  // AZM 2019-08-05 ... NEED TO REMOVE THE SPACE AFTER "not"
	$voCondition.operator:=Replace string:C233($voCondition.operator; "not"; "")
End if 

Case of 
	: (($voCondition.operator="equals") | ($voCondition.operator="literal") | ($voCondition.operator="contains") | ($voCondition.operator="begins with") | ($voCondition.operator="ends with"))
		Case of 
			: (($voCondition.operator="contains") & ($viValueType=Is text:K8:3))
				$voCondition.value:="@"+$voCondition.value+"@"
			: (($voCondition.operator="begins with") & ($viValueType=Is text:K8:3))
				$voCondition.value:=$voCondition.value+"@"
			: (($voCondition.operator="ends with") & ($viValueType=Is text:K8:3))
				$voCondition.value:="@"+$voCondition.value
		End case 
		If ($vbQueryOperatorNot=True:C214)
			$voCondition.operator:="#"
		Else 
			$voCondition.operator:="="
		End if 
	: ($voCondition.operator="greater than")
		$voCondition.operator:=">"
	: ($voCondition.operator="greater than or equals")
		$voCondition.operator:=">="
	: ($voCondition.operator="less than")
		$voCondition.operator:="<"
	: ($voCondition.operator="less than or equals")
		$voCondition.operator:="<="
	Else 
		$voCondition.operator:="="
End case 

// ******************************************************************************************** //
// ** RETURN THE CONDITIONS STRING ************************************************************ //
// ******************************************************************************************** //

$0:=$voCondition