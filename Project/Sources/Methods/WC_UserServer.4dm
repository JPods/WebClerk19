//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/04/21, 23:49:34
// ----------------------------------------------------
// Method: WC_UserServer
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($vbSendConsole)
$vbSendConsole:=True:C214
//If ([EventLog]SecurityLevel<1000)
//voState.request.URL.pathNameTrimmed:="Signin.html"
//WC_PageDocOut($socket)
//   Else 
C_LONGINT:C283($1; $socket)
$socket:=voState.socket
C_TEXT:C284(vMimeType; $vtMimeType)
vMimeType:="application/json"
$vtMimeType:=vMimeType
C_OBJECT:C1216($voPayload)
$voPayload:=New object:C1471
SET BLOB SIZE:C606(vblWCResponse; 0)

C_POINTER:C301($ptTable; $ptUUIDKey)
C_TEXT:C284($vtUUIDKey; $vtPath; $tableName; $isThumbNail; $vttaskID)
C_LONGINT:C283($viTableNum)

C_OBJECT:C1216($obTable)
vResponse:="Error: No ajax handler"
//   WC_GetDefaultParameters




If (Macintosh command down:C546)
	TRACE:C157
End if 

// ### bj ### 20200411_0012 I think we want to make the array the standard.
C_TEXT:C284($vtByArray)
$vtByArray:=WCapi_GetParameter("ReturnArray"; "")  // in value pairs
DateBeginDateEnd(voState.request.parameters)  // setup a general date range
C_OBJECT:C1216($obTable)
C_OBJECT:C1216($voTableData)
$voTableData:=New object:C1471
$voTableData.data:=New object:C1471
$voTableData.version:=Storage:C1525.version.rev
$voTableData.idUser:=[EventLog:75]id:54
$voTableData.error:=""
Case of 
	: ((voState.url="/User/Login@") | (voState.url="/User/signin@"))
		//WccUserLogIn
	: (voState.url="/User/Logout")
		WccResetUser
	: (voState.url="/User/LogoutCustomer")
		Wcc_SignOffCustomer
		
	: (voState.url="/User/list")
		WCapiTask_UserList
		
	: (voState.url="/User/get")
		//Init_User("return object")
		
	: (voState.url="/User/PrintDetails")
		Wcc_SignOffCustomer
		
	: (voState.url="/User/Day@")
		C_OBJECT:C1216($voData)
		$voData:=New object:C1471
		voState.request.parameters.tableName:="Customer"
		WCapiTask_ActionBy
		$voData.Customers:=vResponse
		
		voState.request.parameters.tableName:="Order"
		WCapiTask_ActionBy
		$voData.Orders:=vResponse
		
		voState.request.parameters.tableName:="Invoice"
		WCapiTask_ActionBy
		$voData.Invoices:=vResponse
		
		voState.request.parameters.tableName:="Proposal"
		WCapiTask_ActionBy
		$voData.Proposals:=vResponse
		
		voState.request.parameters.tableName:="Service"
		WCapiTask_ActionBy
		$voData.Service:=vResponse
		
		vResponse:=JSON Stringify:C1217($voData)
		
	: (voState.url="/User/Customers/ActionBy@")
		voState.request.parameters.tableName:="Customer"
		
	: (voState.url="/User/Orders/ActionBy@")
		voState.request.parameters.tableName:="Order"
		WCapiTask_ActionBy
		
	: (voState.url="/User/Invoices/ActionBy@")
		voState.request.parameters.tableName:="Invoice"
		WCapiTask_ActionBy
		
	: (voState.url="/User/Proposals/ActionBy@")
		voState.request.parameters.tableName:="Proposal"
		WCapiTask_ActionBy
		
	: (voState.url="/User/WorkOrders/ActionBy@")
		voState.request.parameters.tableName:="WorkOrder"
		WCapiTask_ActionBy
		
	: (voState.url="/User/Service/ActionBy@")
		voState.request.parameters.tableName:="Service"
		WCapiTask_ActionBy
		
	Else 
		vResponse:="Error: No axaj handler: "+Substring:C12(voState.url; 1; 40)
		// leave a no default. Must specify ajax type in cases able
End case 

If (vResponse="Err@")
	$voTableData.error:=vResponse
	vResponse:=JSON Stringify:C1217($voTableData)
End if 
WC_SendServerResponse(vResponse; "application/json")
// WCapi_SendFromServer