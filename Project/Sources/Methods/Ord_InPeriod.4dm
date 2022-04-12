//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/10/12, 12:19:22
// ----------------------------------------------------
// Method: Ord_InPeriod
// Description
// 20121010 Modified_BJ to open in new process
//
// Parameters
// ----------------------------------------------------
//Procedure: Ord_InPeriod

ptCurTable:=(->[Order:3])
vHere:=0
jBetweenDates("Ordered in Period.")
If (OK=1)
	QUERY:C277([Order:3]; [Order:3]dateOrdered:4>=vdDateBeg; *)
	QUERY:C277([Order:3];  & [Order:3]dateOrdered:4<=vdDateEnd)
	
	If (Records in selection:C76([Order:3])=0)
		jAlertMessage(10003)
	Else 
		$viProcess:=Current process:C322
		//MENU BAR(1;$viProcess;*)
		//Process_InitLocal 
		ptCurTable:=(->[Order:3])
		vHere:=0
		ProcessTableOpen(->[Order:3])
	End if 
End if 
