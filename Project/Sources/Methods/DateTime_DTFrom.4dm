//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-12-30T06:00:00Z)
// Method: DateTime_DTFrom
// Description 
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $timeMod)  //time stamp input
C_POINTER:C301($2; $3)
If ($1#0)  //0 is undefined
	$2->:=!1990-01-01!+($1\86400)  //86400=24*60*60
	$timeMod:=Abs:C99($1%86400)
	If (Count parameters:C259>2)
		$3->:=Time:C179(Time string:C180($timeMod))
	End if 
Else 
	$2->:=!00-00-00!
	If (Count parameters:C259>2)
		$3->:=?00:00:00?
	End if 
End if 