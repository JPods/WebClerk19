//%attributes = {"publishedWeb":true}
//Method: jDateTimeRBoth
C_LONGINT:C283($1; $calcLong; $timeMod)  //time stamp input
C_DATE:C307($2; $dateBase)
If (Count parameters:C259>0)
	$calcLong:=$1
	If (Count parameters:C259>1)
		$dateBase:=$2
	Else 
		$dateBase:=!1990-01-01!
	End if 
Else 
	$calcLong:=0
End if 
C_DATE:C307($theDate)
C_TIME:C306($theTime)
C_TEXT:C284($0)
If ($calcLong#0)  //0 is undefined
	$theDate:=$dateBase+($calcLong\86400)  //86400=24*60*60
	$timeMod:=Abs:C99($calcLong%86400)
	$theTime:=Time:C179(Time string:C180($timeMod))
Else 
	$theDate:=!00-00-00!
	$theTime:=?00:00:00?
End if 
$0:=String:C10($theDate; Internal date short special:K1:4)+" "+String:C10($theTime; HH MM SS:K7:1)