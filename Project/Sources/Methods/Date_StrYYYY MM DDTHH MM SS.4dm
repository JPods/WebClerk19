//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/17/18, 10:01:09
// ----------------------------------------------------
// Method: Date_StrYYYY MM DDTHH MM SS
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Procedure: Date_strYyyymmdd
If (False:C215)
	//Date: 03/01/02
	//Who: Peter Fleming, Arkware
	//Description: Function - pass a date - returns string in yyyymmdd format
	VERSION_960
End if 
C_TEXT:C284($0; $dateSpacer; $timeSpacer; $dtSpacer; $3; $4; $5; $timeStr; $dateStr)
C_DATE:C307($1; $theDate)
C_LONGINT:C283($paraCount)
C_TIME:C306($theTime; $2)
$dateSpacer:="-"
$timeSpacer:="."
$dtSpacer:="T"
$theDate:=Current date:C33
$theTime:=Current time:C178
$paraCount:=Count parameters:C259
If ($paraCount>0)
	$theDate:=$1
	If ($paraCount>1)
		$theTime:=$2
		If ($paraCount>2)
			$dtSpacer:=$3
			If ($paraCount>3)
				$dateSpacer:=$4
				If ($paraCount>4)
					$timeSpacer:=$5
				End if 
			End if 
		End if 
	End if 
End if 
$timeStr:=Replace string:C233(String:C10($theTime; 1); ":"; $timeSpacer)
$dateStr:=String:C10(Year of:C25($theDate); "0000")+$dateSpacer+String:C10(Month of:C24($theDate); "00")+$dateSpacer+String:C10(Day of:C23($theDate); "00")
$dateStr:=$dateStr+$dtSpacer+$timeStr
$0:=$dateStr