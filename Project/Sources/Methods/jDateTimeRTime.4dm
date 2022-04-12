//%attributes = {"publishedWeb":true}
//(GP)jDateTimeRTime
C_TIME:C306($0)  //The Time this DT Represents
C_LONGINT:C283($1; $timeMod)  //time stamp input
If ($1#0)  //0 is undefined
	$timeMod:=Abs:C99($1%86400)
	$0:=Time:C179(Time string:C180($timeMod))
Else 
	$0:=?00:00:00?
End if 