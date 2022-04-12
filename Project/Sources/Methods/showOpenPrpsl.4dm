//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/03/19, 08:40:25
// ----------------------------------------------------
// Method: showOpenPrpsl
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301(ptCurTable)

If (<>prcControl=1)
	<>prcControl:=0
	WindowOpenTaskOffSets
	Process_InitLocal
	ptCurTable:=(->[Control:1])
End if 

QUERY:C277([Proposal:42]; [Proposal:42]complete:56=False:C215)

// ### jwm ### 20190403_1044 open in new process
If (Records in selection:C76([Proposal:42])>0)
	ProcessTableOpen(Table:C252(->[Proposal:42]); ""; "Open Proposals")
Else 
	ALERT:C41("No Open Proposals")
End if 



