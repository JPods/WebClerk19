//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/16/20, 10:28:07
// ----------------------------------------------------
// Method: CND_ParseBoolean
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

C_TEXT:C284($2; $vtOutputType)  // "ORDA"|"traditional"
$vtOutputType:=$2



// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** /

// LOAD DEFAULTS FOR OPERATOR IF NOT SPECIFIED

If (OB Is defined:C1231($voCondition; "boolean")=False:C215)
	$voCondition.boolean:="and"
Else 
	If ($voCondition.boolean#"or")
		$voCondition.boolean:="and"
	End if 
End if 

// CONVERT THE OPERATOR TO 4D OPERATOR SCRIPT

If ($vtOutputType="traditional")
	
	Case of 
		: ($voCondition.boolean="or")
			$voCondition.boolean:=" |; "
		Else 
			$voCondition.boolean:=" &; "
	End case 
	
End if 

// ******************************************************************************************** //
// ** RETURN THE CONDITIONS STRING ************************************************************ //
// ******************************************************************************************** //

$0:=$voCondition