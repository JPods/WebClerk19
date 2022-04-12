//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/27/08, 14:14:15
// ----------------------------------------------------
// Method: jDaysWork
// Description
// 
//
// Parameters
// ----------------------------------------------------
//jDaysWork (vi4;bSkipWkEnd;bFixbyDays;vdDateBeg;vdDateEnd;[Customer]Shipp
C_POINTER:C301($1; $ptDaysInTransit; $4; $ptShipOnDate; $5; $ptNeedDate)
C_LONGINT:C283($workDays; $curDay; $dateSpread; bFixbyDays; $transDays; $7; $numShipDays; $viSkipWeekEnds; $2; $viFixByDays; $3; $6; $baseShippingDays)
C_LONGINT:C283(bSkipWkEnd)
$ptDaysInTransit->:=$1
$viSkipWeekEnds:=$2
$viFixByDays:=$3
$ptShipOnDate:=$4
$ptNeedDate:=$5
$baseShippingDays:=$6
$numShipDays:=$7
If ($numShipDays<3)
	Case of 
		: (($viSkipWeekEnds=1) & ($viFixByDays=1))
			Case of 
				: (Day number:C114($ptShipOnDate->)=1)
					$ptShipOnDate->:=$ptShipOnDate->-2
				: (Day number:C114($ptShipOnDate->)=7)
					$ptShipOnDate->:=$ptShipOnDate->-1
			End case 
			If (allowAlerts_boo)
				If ($ptShipOnDate-><Current date:C33)
					ALERT:C41("You have set a ship date that is BEFORE today.")
				End if 
			End if 
			$dateSpread:=$ptNeedDate->-$ptShipOnDate->
			$ptDaysInTransit->:=0
			$transDays:=0
			$workDays:=0
			If ($viSkipWeekEnds=1)
				$curDay:=Day number:C114($ptShipOnDate->)
				Repeat 
					If (($curDay=1) | ($curDay=7))
						$transDays:=$transDays+1
					Else 
						$transDays:=$transDays+1
						$workDays:=$workDays+1
					End if 
					$curDay:=Day number:C114($ptShipOnDate->+$transDays)
				Until ($workDays>=$baseShippingDays)
				Case of 
					: ($curDay=1)
						$transDays:=$transDays+1
					: ($curDay=7)
						$transDays:=$transDays+2
				End case 
			Else 
				$transDays:=$baseShippingDays
				$curDay:=Day number:C114($ptShipOnDate->+$transDays)
			End if 
			$ptDaysInTransit->:=$transDays
			$ptNeedDate->:=$ptShipOnDate->+$transDays
		: ($viFixByDays=1)
			$ptDaysInTransit->:=$baseShippingDays
			$ptNeedDate->:=$ptShipOnDate->+$baseShippingDays
		Else 
			$ptDaysInTransit->:=$baseShippingDays
	End case 
Else 
	Case of 
		: (($viSkipWeekEnds=1) & ($viFixByDays=1))
			Case of 
				: (Day number:C114($ptNeedDate->)=1)
					$ptNeedDate->:=$ptNeedDate->+1
				: (Day number:C114($ptNeedDate->)=7)
					$ptNeedDate->:=$ptNeedDate->+2
			End case 
			$dateSpread:=$ptNeedDate->-$ptShipOnDate->
			$ptDaysInTransit->:=0
			$transDays:=0
			$workDays:=0
			If ($viSkipWeekEnds=1)
				$curDay:=Day number:C114($ptNeedDate->)
				Repeat 
					If (($curDay=1) | ($curDay=7))
						$transDays:=$transDays+1
					Else 
						$transDays:=$transDays+1
						$workDays:=$workDays+1
					End if 
					$curDay:=Day number:C114($ptNeedDate->-$transDays)
				Until ($workDays>=$baseShippingDays)
				Case of 
					: ($curDay=1)
						$transDays:=$transDays+2
					: ($curDay=7)
						$transDays:=$transDays+1
				End case 
			Else 
				$transDays:=$baseShippingDays
				$curDay:=Day number:C114($ptNeedDate->-$transDays)
			End if 
			$ptDaysInTransit->:=$transDays
			$ptShipOnDate->:=$ptNeedDate->-$transDays
		: ($viFixByDays=1)
			$ptDaysInTransit->:=$baseShippingDays
			$ptShipOnDate->:=$ptNeedDate->-$baseShippingDays
		Else 
			$ptDaysInTransit->:=$baseShippingDays
	End case 
	If (allowAlerts_boo)
		If (($ptShipOnDate-><Current date:C33) & ($ptShipOnDate->#!00-00-00!))
			ALERT:C41("You have set a ship date that is BEFORE today.")
		End if 
	End if 
End if 