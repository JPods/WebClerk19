C_DATE:C307($startDate)
C_TIME:C306(v1Time)
KeyModifierCurrent
//  CHOPPED  TM_GetTime(ePopTime; "v1Time")
Case of 
	: ((CmdKey=1) & (OptKey=1))
		vt06Complet:=v1Time
		[Service:6]complete:17:=True:C214
		[Service:6]dtComplete:18:=DateTime_Enter(d06Complete; vt06Complet)
	: (ShftKey=1)
		vt06Enter:=v1Time
		[Service:6]dtDocument:16:=DateTime_Enter(d06Enter; vt06Enter)
	: (OptKey=1)
		vt06Begin:=v1Time
		[Service:6]dtBegin:15:=DateTime_Enter(d06Begin; vt06Begin)
	: (CmdKey=1)
		vt06End:=v1Time
		[Service:6]dtEnd:38:=DateTime_Enter(d06End; vt06End)
	Else 
		//[Service]RS_ActionTime:=v1Time
		vt06Action:=v1Time
		[Service:6]dtAction:35:=DateTime_Enter(d06Action; vt06Action)
End case 