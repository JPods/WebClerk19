//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/20/20, 10:59:33
// ----------------------------------------------------
// Method: DT_ImportFromString
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($0; $viDateTimeInSeconds)

C_TEXT:C284($1; $vtDateTimeString)
$vtDateTimeString:=$1

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($viPosSep)

C_DATE:C307($vdDate)
C_TIME:C306($vhTime)

// ******************************************************************************************** //
// ** LOAD THE MONTH NAME AND SHORTEN IF NEEDED *********************************************** //
// ******************************************************************************************** //

// CHECK TO SEE IF THE STRING CONTAINS SEPARATOR CHARACTERS COMMON IN DATE TIME STRINGS

If (String:C10(Num:C11($vtDateTimeString))=$vtDateTimeString)
	
	$viDateTimeInSeconds:=Num:C11($vtDateTimeString)
	
Else 
	
	// SWITCH "T" SEPARATOR TO " "
	
	$vtDateTimeString:=Replace string:C233($vtDateTimeString; "T"; " ")
	
	// GET THE DATE
	
	$vdDate:=Date_GoFigure($vtDateTimeString)
	
	// GET THE TIME
	
	$viPosSep:=Position:C15(" "; $vtDateTimeString)
	If ($viPosSep>0)
		$vhTime:=Time:C179(Substring:C12($vtDateTimeString; $viPosSep+1))
	Else 
		$vhTime:=?00:00:00?
	End if 
	
	$viDateTimeInSeconds:=DT_ImportFromDateAndTime($vdDate; $vhTime)
	
End if 

// ******************************************************************************************** //
// ** RETURN THE STRING *********************************************************************** //
// ******************************************************************************************** //

$0:=$viDateTimeInSeconds