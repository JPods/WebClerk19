//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/20/20, 10:59:33
// ----------------------------------------------------
// Method: Date_ExportToString
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtDateString)

C_DATE:C307($1; $vdDate)
$vdDate:=$1

C_TEXT:C284($vtStringFormat)
$vtStringFormat:="Locale"
If (Count parameters:C259>=2)
	C_TEXT:C284($2)
	If ($2="ISO")
		$vtStringFormat:=$2
	End if 
End if 

C_TEXT:C284($vtDefaultIfDateIsNull)
$vtDefaultIfDateIsNull:="Not Set"
If (Count parameters:C259>=3)
	C_TEXT:C284($3)
	$vtDefaultIfDateIsNull:=$3
End if 



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //



// ******************************************************************************************** //
// ** LOAD THE MONTH NAME AND SHORTEN IF NEEDED *********************************************** //
// ******************************************************************************************** //

// CONVERT THE DATE INTO A STRING

If ($vtStringFormat="ISO")
	If ($vdDate=!00-00-00!)
		$vtDateString:=""
	Else 
		$vtDateString:=Replace string:C233(String:C10($vdDate; ISO date:K1:8; ?00:00:00?); "T00:00:00"; "")
	End if 
Else 
	If ($vdDate=!00-00-00!)
		$vtDateString:=$vtDefaultIfDateIsNull
	Else 
		$vtDateString:=String:C10($vdDate; Internal date short:K1:7)
	End if 
End if 



// ******************************************************************************************** //
// ** RETURN THE STRING *********************************************************************** //
// ******************************************************************************************** //

$0:=$vtDateString