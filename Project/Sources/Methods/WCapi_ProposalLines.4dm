//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/12/21, 22:31:55
// ----------------------------------------------------
// Method: WCapi_ProposalLines
// Description
// 
//
// Parameters
// ----------------------------------------------------
voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
WCapi_SetParameter("tableName"; "ProposalLine")
TRACE:C157
Case of 
	: (voState.url="/Get")
		WCapiTask_GetRecordByUUIDKey
	: (voState.url="/GetLines@")
		WCapi_SetParameter("tableName"; "Proposal")
		WCapiTask_GetLines
	: (voState.url="/SaveAll")
		WCapi_SetParameter("tableName"; "Proposal")
		WCapi_ParseProposalLines
	: (voState.url="/Save")
		WCapiTask_SaveRecord
	: (voState.url="/Delete")
		WCapiTask_DeleteRecord
	Else 
		WCapiTask_TallyMasters
End case 