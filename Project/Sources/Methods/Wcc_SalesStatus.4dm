//%attributes = {}
If (False:C215)
	Version_0602
	//Wcc_SalesStatus
End if 
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
$c:=$1
$suffix:=""
$doThis:=0
//zttp_UserGet 
vResponse:=""
READ WRITE:C146([Customer:2])
Case of 
	: ((voState.url="/WCC_SalesStatus@") & ([EventLog:75]securityLevel:16>=<>vbSaleLevel))  //
		Http_SalesStats($c; ->vText11)
		$doThis:=1
		//
	: ((voState.url="/WCC_SalesCalendar@") & ([EventLog:75]securityLevel:16>=<>vbSaleLevel))  //post Proposal
		Http_Calendar($c; ->vText11)
		$doThis:=1
End case 
