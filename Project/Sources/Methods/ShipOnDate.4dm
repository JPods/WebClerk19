//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/18/08, 06:34:49
// ----------------------------------------------------
// Method: ShipOnDate
// Description
// 
//
// Parameters
C_DATE:C307($0; $vShipOnDate; $1; $vNeedDate)
C_LONGINT:C283($2; $baseShippingDays)
//Process Variables set
C_LONGINT:C283(numShippingDays)
// ----------------------------------------------------
C_LONGINT:C283($workDays; $curDay; $dateSpread; bFixbyDays; $transDays; $viSkipWeekEnds; $viFixByDays; $baseShippingDays)
C_LONGINT:C283(bSkipWkEnd)
$viSkipWeekEnds:=1
$viFixByDays:=1
//$vShipOnDate:=$1
$vNeedDate:=$1
$baseShippingDays:=$2
Case of 
	: (($viSkipWeekEnds=1) & ($viFixByDays=1))
		Case of 
			: (Day number:C114($vNeedDate)=1)
				$vNeedDate:=$vNeedDate+1
			: (Day number:C114($vNeedDate)=7)
				$vNeedDate:=$vNeedDate+2
		End case 
		$dateSpread:=$vNeedDate-$vShipOnDate
		numShippingDays:=0
		$transDays:=0
		$workDays:=0
		If ($viSkipWeekEnds=1)
			$curDay:=Day number:C114($vNeedDate)
			Repeat 
				If (($curDay=1) | ($curDay=7))
					$transDays:=$transDays+1
				Else 
					$transDays:=$transDays+1
					$workDays:=$workDays+1
				End if 
				$curDay:=Day number:C114($vNeedDate-$transDays)
			Until ($workDays>=$baseShippingDays)
			Case of 
				: ($curDay=1)
					$transDays:=$transDays+2
				: ($curDay=7)
					$transDays:=$transDays+1
			End case 
		Else 
			$transDays:=$baseShippingDays
			$curDay:=Day number:C114($vNeedDate-$transDays)
		End if 
		numShippingDays:=$transDays
		$vShipOnDate:=$vNeedDate-$transDays
	: ($viFixByDays=1)
		numShippingDays:=$baseShippingDays
		$vShipOnDate:=$vNeedDate-$baseShippingDays
	Else 
		numShippingDays:=$baseShippingDays
End case 

If (($vShipOnDate<Current date:C33) & ($vShipOnDate#!00-00-00!))
	$0:=Current date:C33+1
	//[Order]DateNeeded:=[Order]DateShipOn+numShippingDays
	If (allowAlerts_boo)
		
		//ALERT("You have set a ship date that is BEFORE today.")
	End if 
	//$vNeedDate:=Current date+$transDays
	//$vShipOnDate:=Current date
End if 


If (False:C215)
	//else
	Case of 
		: (($viSkipWeekEnds=1) & ($viFixByDays=1))
			Case of 
				: (Day number:C114($vShipOnDate)=1)
					$vShipOnDate:=$vShipOnDate-2
				: (Day number:C114($vShipOnDate)=7)
					$vShipOnDate:=$vShipOnDate-1
			End case 
			If (allowAlerts_boo)
				If ($vShipOnDate<Current date:C33)
					ALERT:C41("You have set a ship date that is BEFORE today.")
				End if 
			End if 
			$dateSpread:=$vNeedDate-$vShipOnDate
			numShippingDays:=0
			$transDays:=0
			$workDays:=0
			If ($viSkipWeekEnds=1)
				$curDay:=Day number:C114($vShipOnDate)
				Repeat 
					If (($curDay=1) | ($curDay=7))
						$transDays:=$transDays+1
					Else 
						$transDays:=$transDays+1
						$workDays:=$workDays+1
					End if 
					$curDay:=Day number:C114($vShipOnDate+$transDays)
				Until ($workDays>=$baseShippingDays)
				Case of 
					: ($curDay=1)
						$transDays:=$transDays+1
					: ($curDay=7)
						$transDays:=$transDays+2
				End case 
			Else 
				$transDays:=$baseShippingDays
				$curDay:=Day number:C114($vShipOnDate+$transDays)
			End if 
			numShippingDays:=$transDays
			$vNeedDate:=$vShipOnDate+$transDays
		: ($viFixByDays=1)
			numShippingDays:=$baseShippingDays
			$vNeedDate:=$vShipOnDate+$baseShippingDays
		Else 
			numShippingDays:=$baseShippingDays
	End case 
	
End if 