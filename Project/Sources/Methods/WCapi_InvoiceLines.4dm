//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/12/21, 22:37:01
// ----------------------------------------------------
// Method: WCapi_InvoiceLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
WCapi_SetParameter("tableName"; "InvoiceLine")
Case of 
	: (voState.url="/Get")
		WCapi_SetParameter("tableName"; "InvoiceLine")
		WCapiTask_GetRecordByUUIDKey
	: (voState.url="/GetLines@")
		WCapi_SetParameter("tableName"; "Invoice")
		WCapiTask_GetLines
		
	: (voState.url="/SaveAll")
		WCapi_ParseInvoiceLines
		
	: (voState.url="/Save")
		WCapi_SetParameter("tableName"; "InvoiceLine")
		WCapiTask_SaveRecord
	: (voState.url="/Delete")
		WCapiTask_DeleteRecord
	Else 
		WCapiTask_TallyMasters
End case 