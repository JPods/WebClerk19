MESSAGES OFF:C175
If (<>aNameID>1)
	QUERY:C277([Time:56]; [Time:56]nameID:1=<>aNameID{<>aNameID}; *)
	QUERY:C277([Time:56];  & [Time:56]dateIn:6>=vdDateBeg; *)
	QUERY:C277([Time:56];  & [Time:56]dateIn:6<=vdDateEnd)
	ORDER BY:C49([Time:56]; [Time:56]dateIn:6; [Time:56]timeIn:4)
	TC_FillArrays(Records in selection:C76([Time:56]))
	doSearch:=6
Else 
	BEEP:C151
End if 
MESSAGES ON:C181