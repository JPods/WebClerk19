C_DATE:C307($startDate)
KeyModifierCurrent
//  CHOPPED   MM_GetDate(ePopDate2; vDate1)
If (OptKey=0)
	[TallyResult:73]dtReport:12:=DateTime_Enter(vDate1; vTime1)
	//  jDateTimeRecov ([TallyResult]DTReport;vDate1;vTime1)
Else 
	[TallyResult:73]dtCreated:11:=DateTime_Enter(vDate1; vTime1)
	// jDateTimeRecov ([TallyResult]DTCreated;vDate1;vTime1)
End if 