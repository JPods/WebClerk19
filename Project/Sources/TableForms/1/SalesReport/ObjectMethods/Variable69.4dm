KeyModifierCurrent
//  CHOPPED   MM_GetDate(ePopDate2; v1Date)
Case of 
	: (ShftKey=1)
		vDate2:=v1Date
	: (CmdKey=1)
		vDate3:=v1Date
	: (OptKey=1)
		vDate4:=v1Date
	Else 
		vDate1:=v1Date
End case 