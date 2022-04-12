If (vMod)
	booAccept:=True:C214
	acceptPO
End if 
MESSAGES OFF:C175
Srch_FullDia(->[PO:39])
If (OK=1)
	PoArrayManage(-5)
	doSearch:=0
End if 
MESSAGES ON:C181