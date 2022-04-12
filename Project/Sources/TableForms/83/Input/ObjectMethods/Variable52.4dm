C_DATE:C307($startDate)
C_TIME:C306(v1Time)
KeyModifierCurrent
//  CHOPPED  TM_GetTime(ePopTime; "v1Time")
If (OptKey=0)
	[Requisition:83]actionTime:8:=v1Time
	$tempStr:="Action Time changed to "+String:C10(v1Time)+"."
Else 
	vTime5:=v1Time
	[Requisition:83]dtNeeded:6:=DateTime_Enter(vDate5; vTime5)
	$tempStr:="Need Date changed to "+String:C10(vDate5)+"."
End if 
// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)