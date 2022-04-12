//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/06/21, 22:12:30
// ----------------------------------------------------
// Method: WC_AdminServer
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (Macintosh command down:C546)
	TRACE:C157
End if 
Case of 
	: (voState.url="/WCapi/Admin/SelectListsAll")
		SelectList_ReturnAll
		//  : (voState.url="/WCapi/Admin/SelectListContractDetail")
		
	: (voState.url="/WCapi/Admin/SelectListOne")
		C_OBJECT:C1216($obOutPut)
		$vtNameArray:=WCapi_GetParameter("selectList")
		$obOutPut:=New object:C1471
		$obOutPut[$vtNameArray]:=SelectList_One($vtNameArray)
		If (vResponse#"Err@")
			vResponse:=JSON Stringify:C1217($obOutPut)
		End if 
	Else 
		WCapiTask_TallyMasters
End case 
WC_SendServerResponse(vResponse; "application/json")
//  WCapi_SendFromServer