//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/20, 18:26:33
// ----------------------------------------------------
// Method: WCapi_Customers
// Description
// 
//
// Parameters
// ----------------------------------------------------

voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
WCapi_SetParameter("tableName"; "Customer")
voState.tableName:="Customer"
Case of 
	: (voState.url="/Get")
		WCapiTask_GetRecordByUUIDKey
	: (voState.url="/Save")
		WCapiTask_SaveRecord
	: (voState.url="/GetActionBy@")
		WCapiTask_ActionBy
	: (voState.url="/GetByKeyTags@")
		WCapiTask_KeyTags
		
	: (voState.url="/GetBy/@")
		C_OBJECT:C1216($obSel)
		C_TEXT:C284($vtField; $vtValue)
		$vtField:=Substring:C12(voState.url; 8)
		$vtValue:=WCapi_SetParameter("value")
		$obSel:=ds:C1482.Customer.query($vtField+" =  "+$vtValue+"@")
		$vtRole:="Sales"
		$vtPurpose:="list"
		$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
		vResponse:=API_EntityToText($obSel; $vtFieldList)
		
		
	: (voState.url="/GetQA@")
		WCapiTask_GetQA
	: (voState.url="/GetByLastName@")  //  wcapi/customers/GetByLastName
		// not defined
		//WCapiTask_GetByName
		// not defined
	: (voState.url="/GetBetween@")  //  wcapi/customers/GetByLastName
		// not defined
		WCapiTask_Between
		// not defined
	: (voState.url="/GetByQuery@")  //  wcapi/customers/GetByLastNam
		WCapiTask_Query
	: (voState.url="/Delete@")
		vResponse:="Error: Delete is not a web function."
	: (voState.url="/SaveRecord@")
		WCSave_Customers
	Else 
		WCapiTask_TallyMasters
End case 
