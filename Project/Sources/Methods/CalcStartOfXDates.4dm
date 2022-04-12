//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/09/19, 14:58:18
// ----------------------------------------------------
// Method: CalcStartOfXDates
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
C_OBJECT:C1216($0; $voDates)

// vdCurrent IS THE SPECIFIED DATE WHICH WE WILL USE TO BACK CALCULATE THE START OF WEEK, MONTH, AND YEAR FROM
C_DATE:C307($1; $vdCurrent)
$vdCurrent:=$1

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE ADDITIONAL LOCAL VARIABLES ****************************************** //
// ******************************************************************************************** //

C_DATE:C307($vdSoW; $vdSoM; $vdSoY)
C_LONGINT:C283($viWeekDay)




// ******************************************************************************************** //
//** CALCULATE THE START OF PERIOD DATES *******************************************************//
// ******************************************************************************************** //

$viWeekDay:=Day number:C114($vdCurrent)
If ($viWeekDay=1)
	$viWeekDay:=8
End if 

$vdSoW:=$vdCurrent-$viWeekDay+2
$vdSoM:=$vdCurrent-Day of:C23($vdCurrent)+1
$vdSoY:=Date:C102("1/1/"+String:C10(Year of:C25($vdCurrent)))

OB SET:C1220($voDates; "SoW"; $vdSoW)
OB SET:C1220($voDates; "SoM"; $vdSoM)
OB SET:C1220($voDates; "SoY"; $vdSoY)



// ******************************************************************************************** //
//** RETURN THE CALCULATED DATES ***************************************************************//
// ******************************************************************************************** //

$0:=$voDates