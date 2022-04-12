MESSAGES OFF:C175
QUERY:C277([Time:56];  & [Time:56]dateIn:6>=vdDateBeg; *)
QUERY:C277([Time:56];  & [Time:56]dateIn:6<=vdDateEnd)
ORDER BY:C49([Time:56]; [Time:56]nameID:1; [Time:56]dateIn:6; [Time:56]timeIn:4)
TC_FillArrays(Records in selection:C76([Time:56]))
doSearch:=6
MESSAGES ON:C181