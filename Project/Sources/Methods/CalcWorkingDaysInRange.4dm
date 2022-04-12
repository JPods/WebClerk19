//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/09/19, 14:56:55
// ----------------------------------------------------
// Method: CalcWorkingDaysInRange
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //


// PROCESS VARIABLES:

// $viNumWorkingDays IS THE NUMBER OF WORKING DAYS IN THE SPECIFIED DATE RANGE
C_LONGINT:C283($0; $viNumWorkingDays)
$viNumWorkingDays:=0

// $vdStart IS THE DATE OF THE BEGINNING OF THE SPECIFIED DATE RANGE
C_DATE:C307($1; $vdStart)
$vdStart:=$1

// $vdEnd IS THE DATE OF THE END OF THE SPECIFIED DATE RANGE
C_DATE:C307($2; $vdEnd)
$vdEnd:=$2

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE ADDITIONAL LOCAL VARIABLES ****************************************** //
// ******************************************************************************************** //

C_DATE:C307($vdCurrentDay)
$vdCurrentDay:=$vdStart

ARRAY DATE:C224($adHolidays; 0)

// ******************************************************************************************** //
//** GET HOLIDAYS FOR MONTH ********************************************************************//
// ******************************************************************************************** //

// QUERY FOR THE YEARLY HOLIDAY RECORD

DB_QueryByStringSafe("Holidays"; ("Date>="+String:C10($vdStart)+";&;Date<="+String:C10($vdEnd)))

// SPLIT THE COMMA DELIMITED STRING INTO A TEXT ARRAY

DB_SelectionToArray("Holidays"; "Date"; ->$adHolidays)

// UNLOAD THE HOLIDAY RECORDS

DB_UnloadCurRecord("Holidays")

// CALCULATE THE NUMBER OF WORKING DAYS IN THIS MONTH

Repeat 
	
	If ((Day number:C114($vdCurrentDay)#1) & (Day number:C114($vdCurrentDay)#7) & (Find in array:C230($adHolidays; $vdCurrentDay)=-1))
		
		$viNumWorkingDays:=$viNumWorkingDays+1
		
	End if 
	
	$vdCurrentDay:=Add to date:C393($vdCurrentDay; 0; 0; 1)
	
Until ($vdCurrentDay=Add to date:C393($vdEnd; 0; 0; 1))



// ******************************************************************************************** //
//** RETURN THE NUMBER OF WORKING DAYS *********************************************************//
// ******************************************************************************************** //

$0:=$viNumWorkingDays