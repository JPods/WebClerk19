//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/22/06, 22:29:48
// ----------------------------------------------------
// Method: CalendarListEmployees
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
$doPage:=WC_DoPage("Error.html"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
If ($jitPageOne="")
	$jitPageOne:=WCapi_GetParameter("jitPageList"; "")
End if 
$doPage:=WC_DoPage("CwcEmployeesList.html"; $jitPageOne)
//QUERY([RemoteUser];[RemoteUser]Key="fals@")
If ([QQQRemoteUser:57]securityLevel:4>4000)
	QUERY:C277([QQQRemoteUser:57]; [QQQRemoteUser:57]key:21#""; *)
	QUERY:C277([QQQRemoteUser:57];  & [QQQRemoteUser:57]key:21#"fals@")
	//QUERY([RemoteUser];[RemoteUser]Key#"fals@")
Else 
	REDUCE SELECTION:C351([QQQRemoteUser:57]; 0)
	//stay with the current record
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)


//http://localhost:8080/Calendar_EmployeesList?UserName=Employee&Password=Test&TableName=Service

//http://localhost:8080/Calendar_Load?UserName=Employee&Password=test&TableName=WorkOrders