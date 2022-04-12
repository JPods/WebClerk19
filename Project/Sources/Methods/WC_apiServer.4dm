//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/20, 14:58:03
// ----------------------------------------------------
// Method: WC_apiServer
// Description
// WccAcceptTasks
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($voTableData)


//  Study this more TESTQQQ 
//  https://doc.4d.com/4Dv18/4D/18/Entities.300-4575755.en.html
// https://doc.4d.com/4Dv18/4D/18.4/entitysave.305-5234048.en.html
//C_OBJECT($entity_json)
//$entity_json:=JSON Stringify($myentity.toObject())
allowAlerts_boo:=False:C215
C_TEXT:C284(strCurrency)
vResponse:=""  // clear risk of cookies
voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
If (Macintosh command down:C546)
	// ### bj ### 20181231_1802 for debugging
	TRACE:C157
End if 
C_LONGINT:C283(<>letMeIn_i)
If (<>letMeIn_i>0)
	ConsoleMessage("<>letMeIn_i Security Setting: "+String:C10(<>letMeIn_i))
End if 
If (voState.user.wcc.securityLevel=Null:C1517)
	ConsoleMessage("user.wcc.security is null, voState.urlOriginal: "+voState.urlOriginal)
End if 
Case of 
		//: ((voState.user.wcc.securityLevel<5000) & (<>letMeIn_i=0))
		// vResponse:="Error: Security level must be > 4,999 to use WC_apiServer"
	: (voState.request.parameters=Null:C1517)
		vResponse:="Error: malformed or no payload"
		ConsoleMessage(vResponse+": "+voState.urlOriginal)
		If (<>viDeBugMode>310)
			ConsoleMessage("voState: "+JSON Stringify:C1217(voState))
		End if 
	: ((voState.url="/SelectListsAll") | (voState.url="/Admin/SelectListsAll"))
		SelectList_ReturnAll
	: (voState.url="@/record/@")
		WCapi_RecordBasics
		
		//: (voState.url="@/Delete")
		//WCapiTask_DeleteRecord
		//: (voState.url="@/Save")
		//WCapiTask_SaveRecord
		
		
	: (voState.url="@/warrenty/@")
		
		
	: (voState.url="@/query/@")
		WCapiTask_Query
		//WCapiTask_QueryByObject
		WCapi_QueryByFieldValues
		
	: (voState.url="@/GetBy/@")
		WCapiTask_GetBy
		
	: (voState.url="@/GetOpen@")
		WCapiTask_GetOpen
		
	: (voState.url="@Clone@")
		WCapiTask_Clone
		
	: (voState.url="/task/GetGantt@")
		WCapiTask_GetGanttVue
		
	: (voState.url="/task/SaveList@")
		WCapiTask_SaveKanban
		
	: (voState.url="/kanban/Get@")
		WCapiTask_GetKanban
	: (voState.url="/kanban/save@")
		WCapiTask_GetKanban
		
	: (voState.url="/qa@")
		WCapi_QA
	: (voState.url="/customer@")
		WCapi_Customers
	: (voState.url="/item@")
		WCapi_Items
		
	: (voState.url="/proposalLine@")
		WCapi_ProposalLines
	: (voState.url="/proposal@")
		WCapi_Proposals
		
	: (voState.url="/orderLine@")
		WCapi_OrderLines
	: (voState.url="/order@")
		WCapi_Orders
		
	: (voState.url="/invoiceLine@")
		WCapi_InvoiceLines
	: (voState.url="/invoice@")
		WCapi_Invoices
	: (voState.url="/servic@")
		WCapi_Service
	: (voState.url="/payment@")
		WCapi_Payments
	: (voState.url="/callreport@")
		WCapi_CallReports
	: (voState.url="/contact@")
		WCapi_Contacts
	: (voState.url="/billto@")
		WCapi_BillTo
	: (voState.url="/shipto@")
		WCapi_ShipTo
	: (voState.url="/profile@")
		WCapi_Profiles
	: (voState.url="/workorder@")
		WCapi_WorkOrders
	: (voState.url="/vendor@")
		WCapi_Vendors
	: (voState.url="/po@")
		WCapi_POs
	: (voState.url="/rep@")
		WCapi_Reps
	: (voState.url="/reports@")
		WCapi_Reports
	: (voState.url="/itemSerials@")
		WCapi_SerialNum
	: ((voState.url="/docPaths@") | (voState.url="/image@"))
		WCapiTask_GetDocPath
End case 
WC_SendServerResponse(vResponse; "application/json")
// WCapi_SendFromServer