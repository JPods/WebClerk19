//%attributes = {}



voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
WCapi_SetParameter("tableName"; "Invoice")
voState.tableName:="Invoice"

Case of 
	: (voState.url="/Get")
		WCapiTask_GetRecordByUUIDKey
	: (voState.url="/Save")
		WCapiTask_SaveRecord
		
	: (voState.url="/SaveLines")
		WCapi_ParseInvoiceLines
		
	: (voState.url="/GetLines@")
		WCapiTask_GetLines
		
	: (voState.url="/GetQA@")
		WCapiTask_GetQA
		
	: (voState.url="/Add@")
		WCapiTask_AddRecord
	: (voState.url="/GetActionBy@")
		WCapiTask_ActionBy
		
	: (voState.url="/GetByCustomer@")
		WCapiTask_GetByCustomer
	: (voState.url="/GetCustomer@")
		WCapiTask_GetCustomer
		
	: (voState.url="/MakePayment")
		WCapiTask_Make
		
	: (voState.url="/GetKeyTags@")
		WCapiTask_KeyTags
		
	: (voState.url="/GetStatus@")
		voState.request.parameters.fieldName:="Status"
		WCapiTask_GetOpen
		
	: ((voState.url="/GetByNumber@") | (voState.url="/GetByUnique@"))
		WCapiTask_GetByUnique
		
	: (voState.url="/GetByDateExpected@")
		voState.request.parameters.fieldName:="DateExpected"
		WCapiTask_Between
	: (voState.url="/GetByDateNeeded@")
		voState.request.parameters.fieldName:="DateNeeded"
		WCapiTask_Between
	: (voState.url="/GetBetweenDateProposed@")
		voState.request.parameters.fieldName:="DateProposed"
		WCapiTask_Between
	: (voState.url="/GetBetweenZip@")
		WCapiTask_Between
	: (voState.url="/GetBetween@")
		WCapiTask_Between
	: (voState.url="/Delete@")
		vResponse:="Error: Delete is not a web function."
	Else 
		C_OBJECT:C1216($voTallyMaster)
		$voTallyMaster:=ds:C1482.TallyMaster.query("purpose = :1 AND name = :2"; "WCapi"; voState.url)
		ExecuteText(0; $voTallyMaster.Script)
End case 

