//%attributes = {"publishedWeb":true}
C_DATE:C307($2)
C_TEXT:C284($1; $thePeriod; $testStr)
C_DATE:C307($0; $theDate)
Case of 
	: (Count parameters:C259=0)
		$thePeriod:="month"
		$theDate:=Current date:C33
	: (Count parameters:C259=1)
		$thePeriod:=$1
		$theDate:=Current date:C33
	Else 
		$thePeriod:=$1
		$theDate:=$2
End case 
$day:=Day of:C23($theDate)
$mon:=Month of:C24($theDate)
$yr:=Year of:C25($theDate)
Case of 
	: ($thePeriod="day")
		$0:=$theDate+1
	: ($thePeriod="week")
		$0:=$theDate+7
	Else 
		Case of 
			: ($thePeriod="month")
				If ($mon=12)
					$yr:=$yr+1
					$mon:=1
				Else 
					$mon:=$mon+1
				End if 
			: ($thePeriod="year")
				$yr:=$yr+1
		End case 
		If (<>vbDateByDDMMYY)
			$0:=Date:C102(String:C10($day)+"/"+String:C10($mon)+"/"+String:C10($yr))
		Else 
			$0:=Date:C102(String:C10($mon)+"/"+String:C10($day)+"/"+String:C10($yr))
		End if 
End case 