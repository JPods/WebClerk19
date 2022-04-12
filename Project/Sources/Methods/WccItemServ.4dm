//%attributes = {"publishedWeb":true}
//Method: WccServiceServ
C_LONGINT:C283($1)
C_POINTER:C301($2)
//
TRACE:C157
ALERT:C41("change tables")
vResponse:="Table is not available."
$doPage:=WC_DoPage("Error.html"; "")
$tableName:="Service"
$recordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
C_LONGINT:C283($pageControl)
Case of 
	: (voState.url="/WCC_ServiceToday@")  //Complex Transactions   
		$vlDTStart:=DateTime_Enter(Current date:C33; ?00:00:00?)
		$vlDTEnd:=DateTime_Enter(Current date:C33; ?23:59:59?)
		QUERY:C277([Service:6]; [Service:6]dtAction:35>=$vlDTStart; *)
		QUERY:C277([Service:6];  & [Service:6]dtAction:35<=$vlDTEnd; *)
		If ((vWccSecurity<4999) | (justMine="true"))
			QUERY:C277([Service:6];  & [Service:6]actionBy:12=[Employee:19]nameID:1; *)
		End if 
		QUERY:C277([Service:6])
		
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtAction:5>=$vlDTStart; *)
		QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$vlDTEnd; *)
		If ((vWccSecurity<4999) | (justMine="t@"))
			QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=[Employee:19]nameID:1; *)
		End if 
		QUERY:C277([WorkOrder:66])
		$pageControl:=1
		
	: (voState.url="/WCC_ServiceAction@")  //Complex Transactions    
		$action:=WCapi_GetParameter("Action"; "")
		QUERY:C277([Service:6]; [Service:6]action:20>=$action; *)
		QUERY:C277([Service:6];  & [Service:6]dtComplete:18=0)
		$pageControl:=1
End case 
Case of 
	: (Records in selection:C76([Service:6])=0)
		vResponse:="No matching service records"
	: (Records in selection:C76([Service:6])=1)
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$doPage:=WC_DoPage("WccServiceOne.html"; $jitPageOne)
	Else 
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		$doPage:=WC_DoPage("WccServiceList.html"; $jitPageList)
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)