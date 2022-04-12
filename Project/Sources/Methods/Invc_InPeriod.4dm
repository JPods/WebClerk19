//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/10/12, 12:20:22
// ----------------------------------------------------
// Method: Invc_InPeriod
// Description
// 20121010 Modified_BJ to open in new process
//
// Parameters
// ----------------------------------------------------
//Procedure: Invc_InPeriod
ptCurTable:=(->[Invoice:26])
vHere:=0
jBetweenDates("Invoiced in Period.")
If (OK=1)
	QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=vdDateBeg; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]dateInvoiced:35<=vdDateEnd)
	
	If (Records in selection:C76([Invoice:26])=0)
		jAlertMessage(10003)
	Else 
		$viProcess:=Current process:C322
		//MENU BAR(1;$viProcess;*)
		//Process_InitLocal 
		ptCurTable:=(->[Invoice:26])
		vHere:=0
		ProcessTableOpen(->[Invoice:26])
	End if 
End if 

