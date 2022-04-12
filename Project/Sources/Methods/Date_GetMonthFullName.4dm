//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 01/10/20, 08:07:48
// ----------------------------------------------------
// Method: Date_GetMonthFullName
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtMonthName)

C_LONGINT:C283($viMonthNum)
$viMonthNum:=$1

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

ARRAY TEXT:C222($atMonthNames; 0)
APPEND TO ARRAY:C911($atMonthNames; "January")
APPEND TO ARRAY:C911($atMonthNames; "February")
APPEND TO ARRAY:C911($atMonthNames; "March")
APPEND TO ARRAY:C911($atMonthNames; "April")
APPEND TO ARRAY:C911($atMonthNames; "May")
APPEND TO ARRAY:C911($atMonthNames; "June")
APPEND TO ARRAY:C911($atMonthNames; "July")
APPEND TO ARRAY:C911($atMonthNames; "August")
APPEND TO ARRAY:C911($atMonthNames; "September")
APPEND TO ARRAY:C911($atMonthNames; "October")
APPEND TO ARRAY:C911($atMonthNames; "November")
APPEND TO ARRAY:C911($atMonthNames; "December")

// ******************************************************************************************** //
// ** LOAD THE MONTH NAME AND SHORTEN IF NEEDED *********************************************** //
// ******************************************************************************************** //

If (($viMonthNum>=1) & ($viMonthNum<=12))
	$vtMonthName:=$atMonthNames{$viMonthNum}
Else 
	$vtMonthName:=""
End if 

// ******************************************************************************************** //
// ** RETURN THE MONTH NAME ******************************************************************* //
// ******************************************************************************************** //

$0:=$vtMonthName