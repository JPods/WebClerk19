//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/20, 21:20:32
// ----------------------------------------------------
// Method: WCapi_Service
// Description
voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
WCapi_SetParameter("tableName"; "Service")
voState.tableName:="Service"
Case of 
	: (voState.url="/Get")
		WCapiTask_GetRecordByUUIDKey
		
	: (voState.url="/Save")
		WCapiTask_SaveRecord
	: (voState.url="/SaveRecord@")
		WCapiTask_SaveRecord
	: (voState.url="/Add@")
		WCapiTask_AddRecord
	: (voState.url="/GetActionBy@")
		WCapiTask_ActionBy
		
	: (voState.url="/GetByCustomer@")
		WCapiTask_GetByCustomer
	: (voState.url="/GetCustomer@")
		WCapiTask_GetCustomer
		
	: (voState.url="/GetByDateRange@")
		WCapiTask_Between
	: (voState.url="/GetBetweenZip@")
		WCapiTask_Between
	: (voState.url="/GetBetweenDateProposed@")
		WCapiTask_Between
	: (voState.url="/GetBetween@")
		WCapiTask_Between
	: (voState.url="/GetKeyTags@")
		WCapiTask_KeyTags("Proposal")
	: (voState.url="/GetOpen@")
		WCapiTask_GetOpen
		
	: ((voState.url="/GetByNumber@") | (voState.url="/GetByUnique@"))
		WCapiTask_GetByUnique
		
	: (voState.url="/Delete@")
		vResponse:="Error: Delete is not a web function."
	Else 
		WCapi_TallyMasterCall
End case 