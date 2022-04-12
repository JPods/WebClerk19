//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/19/20, 10:58:34
// ----------------------------------------------------
// Method: Date_GetPeriodBeginDates
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

// $vtHTML. THIS WILL HOLD THE FINAL HTML TEXT STRING, A FULLY
// FINISHED HTML SELECT ELEMENT WITH OPTIONS INSIDE

C_OBJECT:C1216($0; $voPeriodBeginDates)
$voPeriodBeginDates:=New object:C1471

// $vdPeriodEndDate. REQUIRED. THIS PARAMETER IS THE DATE ON WHICH THE PERIODS (WtD, MtD, and YtD) END

C_DATE:C307($1; $vdPeriodEndDate)
$vdPeriodEndDate:=$1



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($viDayofWeek)



// ******************************************************************************************** //
// ** CHECK TO MAKE SURE THAT THE LENGTH OF THE TWO ARRAYS BEING SENT IS THE SAME ************* //
// ******************************************************************************************** //

// GET THE DAY OF WEEK

$viDayofWeek:=Day number:C114($vdPeriodEndDate)
If ($viDayofWeek=1)  // WE DO THIS BECAUSE WE WANT MONDAY TO BE START OF WEEK, BUT 4D CONSIDERS SUNDAY TO BE START OF WEEK.
	$viDayofWeek:=8
End if 

// CALCULATE THE BEGINING OF PERIOD DATES

$voPeriodBeginDates.SoW:=$vdPeriodEndDate-$viDayofWeek+2
$voPeriodBeginDates.SoM:=$vdPeriodEndDate-Day of:C23($vdPeriodEndDate)+1
$voPeriodBeginDates.SoY:=Date:C102("1/1/"+String:C10(Year of:C25($vdPeriodEndDate)))



// ******************************************************************************************** //
// ** RETURN THE OUTPUT *********************************************************************** //
// ******************************************************************************************** //

$0:=$voPeriodBeginDates
