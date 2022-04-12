//%attributes = {"publishedWeb":true}
//(GP)jDateTimeRDate
C_DATE:C307($0)  //The Date this DT represents
C_LONGINT:C283($1; $timeMod)  //time stamp input
If ($1#0)  //0 is undefined
	$0:=!1990-01-01!+($1\86400)  //86400=24*60*60
Else 
	$0:=!00-00-00!
End if 