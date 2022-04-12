//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/10/12, 12:18:05
// ----------------------------------------------------
// Method: PO_InPeriod
// Description
// 20121010 Modified_BJ to open in new process
//
// Parameters
// ----------------------------------------------------
//Procedure: PO_InPeriod
ptCurTable:=(->[PO:39])
vHere:=0

jBetweenDates("PO's in Period.")
If (OK=1)
	QUERY:C277([PO:39]; [PO:39]dateOrdered:2>=vdDateBeg; *)
	QUERY:C277([PO:39];  & [PO:39]dateOrdered:2<=vdDateEnd)
	ProcessTableOpen(->[PO:39])
End if 