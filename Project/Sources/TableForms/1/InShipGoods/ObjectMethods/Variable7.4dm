If (vMod)
	booAccept:=True:C214
	acceptPO
End if 
MESSAGES OFF:C175
doQuickQuote:=1


//   // ### bj ### 20190113_1904
QueryEditorModal(->[PO:39])
//Srch_FullDia (->[PO])
doQuickQuote:=0
If (OK=1)
	PoArrayManage(-5)
	doSearch:=0
End if 
MESSAGES ON:C181