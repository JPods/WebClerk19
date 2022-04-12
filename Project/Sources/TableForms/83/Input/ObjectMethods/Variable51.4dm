C_DATE:C307($startDate)
KeyModifierCurrent
//  CHOPPED   MM_GetDate(ePopDate2; v1Date)
If (OptKey=0)
	[Requisition:83]actionDate:7:=v1Date
	$tempStr:="Action Date changed to "+String:C10(v1Date)+"."
Else 
	vDate5:=v1Date
	[Requisition:83]dtNeeded:6:=DateTime_Enter(v1Date; vTime5)
	$tempStr:="Need Date changed to "+String:C10(v1Date)+"."
End if 
// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)