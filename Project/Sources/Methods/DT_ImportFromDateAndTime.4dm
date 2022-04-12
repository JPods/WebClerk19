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

C_DATE:C307($vdDate)
If (Count parameters:C259>=1)
	C_DATE:C307($1)
	$vdDate:=$1
Else 
	$vdDate:=Current date:C33
End if 

C_TIME:C306($vhTime)
If (Count parameters:C259>=2)
	C_TIME:C306($2)
	$vhTime:=$2
Else 
	$vhTime:=Current time:C178
End if 



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($viSecondsPerDay)
$viSecondsPerDay:=86400

C_DATE:C307($vdDateEpoch)
$vdDateEpoch:=!1990-01-01!



// ******************************************************************************************** //
// ** LOAD THE MONTH NAME AND SHORTEN IF NEEDED *********************************************** //
// ******************************************************************************************** //

$viDateTimeInSeconds:=($vdDate-$vdDateEpoch)*$viSecondsPerDay  //86400=24*60*60 date from 1990

If ($viDateTimeInSeconds>=0)
	$viDateTimeInSeconds:=$viDateTimeInSeconds+$vhTime
Else 
	$viDateTimeInSeconds:=$viDateTimeInSeconds-$vhTime
End if 




// ******************************************************************************************** //
// ** RETURN THE STRING *********************************************************************** //
// ******************************************************************************************** //

$0:=$viDateTimeInSeconds