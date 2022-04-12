//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/16/08, 19:36:35
// ----------------------------------------------------
// Method: dCashInPeriod
// Description
// 
//
// Parameters
// ----------------------------------------------------
jBetweenDates("Period for listing dCash.")
If (OK=1)
	QUERY:C277([DCash:62]; [DCash:62]dateEvent:6>=vdDateBeg; *)
	QUERY:C277([DCash:62];  & [DCash:62]dateEvent:6<=vdDateEnd)
	ProcessTableOpen(Table:C252(->[DCash:62])*-1)
End if 