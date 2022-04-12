//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/20, 17:04:42
// ----------------------------------------------------
// Method: WCapi_Proposals

C_TEXT:C284($vtURL)
voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
WCapi_SetParameter("tableName"; "Proposal")
voState.tableName:="Proposal"
Case of 
	: (voState.url="/Get")
		WCapiTask_GetRecordByUUIDKey
	: (voState.url="/GetCloneList")
		WCapiTask_Clone
	: (voState.url="/SaveClone")
		WCapiTask_Clone
		
	: (voState.url="/SaveRecord@")
		WCapiTask_SaveRecord
		
	: (voState.url="/Save")
		WCapiTask_SaveRecord
		
	: (voState.url="/MakeOrder")
		WCapiTask_Make
		
		
	: (voState.url="/GetLines@")
		WCapiTask_GetLines
	: (voState.url="/GetQA@")
		WCapiTask_GetQA
	: (voState.url="/GetByCustomer@")
		WCapiTask_GetByCustomer
	: (voState.url="/GetCustomer@")
		WCapiTask_GetCustomer
		
		
	: (voState.url="/Add@")
		WCapiTask_AddRecord
	: (voState.url="/GetActionBy@")
		WCapiTask_ActionBy
		
	: (voState.url="/GetByDateRange@")
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
		C_OBJECT:C1216($voTallyMaster)
		$voTallyMaster:=ds:C1482.TallyMaster.query("purpose = :1 AND name = :2"; "WCapi"; $vtURL)
		ExecuteText(0; $voTallyMaster.Script)
End case 