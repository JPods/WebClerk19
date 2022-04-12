MESSAGES OFF:C175
If (vMod)
	booAccept:=True:C214
	acceptPO
End if 
QUERY:C277([PO:39]; [PO:39]completeId:65<2)
PoArrayManage(-5)
doSearch:=0
MESSAGES ON:C181
PoLnFillVar(0)