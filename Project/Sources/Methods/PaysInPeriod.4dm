//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/10/12, 12:19:08
// ----------------------------------------------------
// Method: PaysInPeriod
// Description
// 20121010 Modified_BJ to open in new process
//
// Parameters
// ----------------------------------------------------
ptCurTable:=(->[Payment:28])
vHere:=0
jBetweenDates("Period for listing payments.")
If (OK=1)
	QUERY:C277([Payment:28]; [Payment:28]dateReceived:10>=vdDateBeg; *)
	QUERY:C277([Payment:28];  & [Payment:28]dateReceived:10<=vdDateEnd)
	ProcessTableOpen(->[Payment:28])
End if 