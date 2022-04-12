If (aLoOrdComme=0)
	aLoOrdComme:=Num:C11(<>aEmpPref{3})
End if 
KeyModifierCurrent
If (CmdKey=1)
	TRACE:C157
	QUERY:C277([Employee:19]; [Employee:19]nameid:1=Current user:C182)
	If (Records in selection:C76([Employee:19])=1)
		[Employee:19]orderPref:28:=aLoOrdComme
		<>aEmpPref{3}:=String:C10([Employee:19]orderPref:28)
		SAVE RECORD:C53([Employee:19])
		UNLOAD RECORD:C212([Employee:19])
	End if 
End if 
Ord_Comment(0)