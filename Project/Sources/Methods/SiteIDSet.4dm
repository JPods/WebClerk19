//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-09T00:00:00, 06:48:23
// ----------------------------------------------------
// Method: siteIDSet
// Description
// Modified: 08/09/13
// 
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptField; $ptCurTable; $2; $ptself)
C_LONGINT:C283($selectedValue)
$ptCurTable:=Table:C252(Table:C252($1))
$ptself:=$2
$selectedValue:=$2->
$ptField:=$1
If (Size of array:C274($2->)>1)
	C_LONGINT:C283($type)
	$type:=Type:C295($1->)
	Case of 
		: ($type=Is alpha field:K8:1)
			If (($ptself->)>0)
				jPopUpArray($ptself; $ptField)
				vsiteID:=$ptField->
				If ($ptField->#"")
					DSSetMachineID(vsiteID)
				End if 
			Else 
				KeyModifierCurrent
				If ((cmdKey=1) | (optKey=1))
					ALL RECORDS:C47([DivisionDefault:85])
					DB_ShowCurrentSelection(->[DivisionDefault:85])
				End if 
			End if 
		: ($type=Is string var:K8:2)
			jPopUpArray($ptself; $ptField)
			If ($ptField->#"")
				DSSetMachineID($ptField->)
			End if 
	End case 
End if 
