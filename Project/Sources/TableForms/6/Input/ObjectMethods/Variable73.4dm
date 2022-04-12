C_DATE:C307($startDate)
KeyModifierCurrent
//  CHOPPED   MM_GetDate(ePopDate2; v1Date)
Case of 
	: ((CmdKey=1) & (OptKey=1))
		d06Complete:=v1Date
		[Service:6]complete:17:=True:C214
		[Service:6]dtComplete:18:=DateTime_Enter(d06Complete; vt06Complet)
	: (ShftKey=1)
		d06Enter:=v1Date
		[Service:6]dtDocument:16:=DateTime_Enter(d06Enter; vt06Enter)
	: (OptKey=1)
		d06Begin:=v1Date
		[Service:6]dtDocument:16:=DateTime_Enter(d06Begin; vt06Begin)
	: (CmdKey=1)
		d06End:=v1Date
		[Service:6]dtEnd:38:=DateTime_Enter(d06End; vt06End)
	Else 
		d06Action:=v1Date
		[Service:6]dtAction:35:=DateTime_Enter(d06Action; vt06Action)
End case 