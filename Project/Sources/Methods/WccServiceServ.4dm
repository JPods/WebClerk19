//%attributes = {"publishedWeb":true}
//Method: WccServiceServ
C_LONGINT:C283($1)
C_POINTER:C301($2)
//
vResponse:="Table is not available."
$doPage:=WC_DoPage("Error.html"; "")
$tableName:="Service"
$recordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
C_LONGINT:C283($pageControl)
Case of 
	: (voState.url="/WCC_ServiceToday@")  //Complex Transactions  
		C_LONGINT:C283($dt00; $dt24)
		$dt00:=DateTime_DTTo(Current date:C33; ?00:00:00?)
		$dt24:=DateTime_DTTo(Current date:C33; ?23:59:59?)
		QUERY:C277([Service:6]; [Service:6]actionBy:12=[Employee:19]nameID:1; *)
		QUERY:C277([Service:6];  | [Service:6]actionCreatedBy:40=[Employee:19]nameID:1; *)
		QUERY:C277([Service:6];  | [Service:6]repID:2=[Employee:19]nameID:1; *)
		QUERY:C277([Service:6];  & [Service:6]dtAction:35>=$dt00; *)
		QUERY:C277([Service:6];  & [Service:6]dtAction:35<=$dt24)
		$pageControl:=1
		
	: (voState.url="/WCC_ServiceAction@")  //Complex Transactions    
		$action:=WCapi_GetParameter("Action"; "")
		$action:=$action+"@"
		QUERY:C277([Service:6]; [Service:6]action:20=$action; *)
		QUERY:C277([Service:6];  & [Service:6]dtComplete:18=0)
		$pageControl:=1
		
	: (voState.url="/WCC_ServiceMine@")  //Complex Transactions    
		GOTO RECORD:C242(Table:C252(vWccTableNum)->; vWccPrimeRec)
		QUERY:C277([Service:6]; [Service:6]actionBy:12=[Employee:19]nameID:1; *)
		QUERY:C277([Service:6];  | [Service:6]actionCreatedBy:40=[Employee:19]nameID:1; *)
		QUERY:C277([Service:6];  | [Service:6]repID:2=[Employee:19]nameID:1; *)
		QUERY:C277([Service:6];  & [Service:6]dtComplete:18=0)
		$pageControl:=1
	: (voState.url="/WCC_Service2Order@")  //Complex Transactions    
		GOTO RECORD:C242([Service:6]; $recordNum)
		QUERY:C277([Order:3]; [Order:3]idNum:2=[Service:6]idNumOrder:22)
		If (Records in selection:C76([Order:3])=1)
			$doPage:=WC_DoPage("WccOrdersOne.html"; "")
		End if 
		$pageControl:=2
End case 
Case of 
	: ($pageControl=2)
	: (Records in selection:C76([Service:6])=0)
		vResponse:="No records in selection for :  "+[Employee:19]nameID:1
		$doPage:=WC_DoPage("Comment.html"; "")
	: (Records in selection:C76([Service:6])=1)
		$pageOne:=WCapi_GetParameter("jitPageOne"; "")
		$doPage:=WC_DoPage("WccServiceOne.html"; $pageOne)
	Else 
		$pageList:=WCapi_GetParameter("jitPageList"; "")
		$doPage:=WC_DoPage("WccServiceList.html"; $pageList)
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)