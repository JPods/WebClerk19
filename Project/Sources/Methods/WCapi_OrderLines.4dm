//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/10/21, 07:55:41
// ----------------------------------------------------
// Method: WCapi_OrderLines
// Description
// 
//
// Parameters
// ----------------------------------------------------
voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
WCapi_SetParameter("tableName"; "OrderLine")
Case of 
	: (voState.url="/Get")
		WCapiTask_GetRecordByUUIDKey
	: (voState.url="/GetLines@")
		WCapi_SetParameter("tableName"; "Order")
		WCapiTask_GetLines
	: (voState.url="/SaveAll")
		WCapi_SetParameter("tableName"; "Order")
		WCapi_ParseOrderLines
		// jsonParseOrderLines
	: (voState.url="/Delete")
		WCapiTask_DeleteRecord
	: (voState.url="/Save")
		WCapiTask_SaveRecord
	Else 
		WCapiTask_TallyMasters
End case 