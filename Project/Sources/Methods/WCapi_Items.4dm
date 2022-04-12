//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/31/20, 15:02:58
// ----------------------------------------------------
// Method: WCapi_Items
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($voTableData)
C_OBJECT:C1216($voParameters)
WCapi_SetParameter("tableName"; "Item")
voState.tableName:="Item"
voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
Case of 
	: (voState.url="/ItemNum@")
		C_TEXT:C284($vtItemNum)
		$vtItemNum:=WCapi_GetParameter("itemNum"; "")
		$vtItemNum:=$vtItemNum+"@"
		$tableName:="Item"
		//vResponse:="Error: No record: "+$tableName+": "+$vtItemNum
		vResponse:="[]"
		If ($vtItemNum#"")
			
			C_TEXT:C284($vtItemNum)
			C_OBJECT:C1216($veSelItems; $veRecItems)
			
			$veSelItems:=ds:C1482.Item.query("itemNum = :1"; $vtItemNum)  //  :1 AND Publish > 0  and Publish <= :2 ; 5000)
			If ($veSelItems.length=0)
				vResponse:="[]"
			Else 
				$tableName:="Item"
				$vtRole:="Sales"
				$vtPurpose:="list"
				$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
				vResponse:=API_EntityToText($veSelItems; $vtFieldList)
				voState.result:=$tableName+" records in selection: "+String:C10($veSelItems.length)
			End if 
		End if 
	: (voState.url="/Save")
		WCapiTask_SaveRecord
	: (voState.url="/Get")
		WCapiTask_GetRecordByUUIDKey($voParameters)
		
	: (voState.url="@/GetBy/@")
		WCapiTask_GetBy
		
	: (voState.url="/GetActionBy@")
		WCapiTask_ActionBy
	: (voState.url="/GetByKeyTags@")
		WCapiTask_KeyTags
	: (voState.url="/GetBetween@")  //  wcapi/customers/GetByLastName
		WCapiTask_Between($voParameters)
	: (voState.url="/GetByQuery@")  //  wcapi/customers/GetByLastNam
		WCapiTask_Query($voParameters)
	: (voState.url="/Delete@")
		vResponse:="Error: Delete is not a web function."
	: (voState.url="/SaveRecord@")
		WCapi_SaveRecord("Item")
End case 