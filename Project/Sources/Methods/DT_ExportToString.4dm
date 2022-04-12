//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/20/20, 10:59:33
// ----------------------------------------------------
// Method: DT_ExportAsString
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtOutputString)

C_LONGINT:C283($1; $viDateTimeInSeconds)
$viDateTimeInSeconds:=$1

C_TEXT:C284($vtStringFormat)
$vtStringFormat:="Locale"  // "Locale|ISO"
If (Count parameters:C259>=2)
	C_TEXT:C284($2)
	If ($2="ISO")
		$vtStringFormat:=$2
	End if 
End if 

C_TEXT:C284($vtOutputType)
$vtOutputType:="DateTime"  // "DateTime|Date|Time"
If (Count parameters:C259>=3)
	C_TEXT:C284($3)
	If (($3="Date") | ($3="Time"))
		$vtOutputType:=$3
	End if 
End if 

C_TEXT:C284($vtDefaultIfDateIsNull)
$vtDefaultIfDateIsNull:="Not Set"
If (Count parameters:C259>=4)
	C_TEXT:C284($4)
	$vtDefaultIfDateIsNull:=$4
End if 



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($viSecondsPerDay)
$viSecondsPerDay:=86400

C_DATE:C307($vdDateEpoch)
$vdDateEpoch:=!1990-01-01!

C_LONGINT:C283($viDaysSinceEpoch)
C_LONGINT:C283($viSecondsSinceMidnight)

// ******************************************************************************************** //
// ** LOAD THE MONTH NAME AND SHORTEN IF NEEDED *********************************************** //
// ******************************************************************************************** //

If ($viDateTimeInSeconds#0)
	
	// SPLIT OUT THE PARTIAL DAY, IN SECONDS
	
	$viSecondsSinceMidnight:=$viDateTimeInSeconds%$viSecondsPerDay
	$viDateTimeInSeconds:=$viDateTimeInSeconds-$viSecondsSinceMidnight
	$vhTime:=Time:C179($viSecondsSinceMidnight)
	
	// CONVERT THE REMAINING FULL DAYS FROM SECONDS TO DAYS
	
	$viDaysSinceEpoch:=$viDateTimeInSeconds/$viSecondsPerDay
	$vdDate:=$vdDateEpoch+$viDaysSinceEpoch
	
	// CONVERT THE DATE INTO A STRING
	
	If ($vtStringFormat="ISO")
		$vtOutputString:=String:C10($vdDate; ISO date:K1:8; $vhTime)
		Case of 
			: ($vtOutputType="DateTime")
				// DO NOTHING
			: ($vtOutputType="Date")
				$vtOutputString:=Split string:C1554($vtOutputString; "T")[0]
			: ($vtOutputType="Time")
				$vtOutputString:=Split string:C1554($vtOutputString; "T")[1]
		End case 
	Else 
		Case of 
			: ($vtOutputType="DateTime")
				$vtOutputString:=String:C10($vdDate; Internal date short:K1:7)+" "+String:C10($vhTime; HH MM AM PM:K7:5)
			: ($vtOutputType="Date")
				$vtOutputString:=String:C10($vdDate; Internal date short:K1:7)
			: ($vtOutputType="Time")
				$vtOutputString:=String:C10($vhTime; HH MM AM PM:K7:5)
		End case 
	End if 
	
Else 
	
	If ($vtStringFormat="ISO")
		$vtOutputString:=""
	Else 
		$vtOutputString:=$vtDefaultIfDateIsNull
	End if 
	
End if 

// ******************************************************************************************** //
// ** RETURN THE STRING *********************************************************************** //
// ******************************************************************************************** //

$0:=$vtOutputString