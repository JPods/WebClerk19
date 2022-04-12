//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/30/20, 16:26:55
// ----------------------------------------------------
// Method: WCapiTask_actionBy
// Description

// see:  Cal_SearchMySales

C_TEXT:C284($tableName; $vtUserName)
C_POINTER:C301($ptTable)
$tableName:=WCapi_GetParameter("tableName")
$ptTable:=STR_GetTablePointer($tableName)
If (Is nil pointer:C315($ptTable))
	vResponse:="Error: tableName not correcly defined: "+$tableName
Else 
	$vtUserName:=WCapi_GetParameter("actionBy")
	If (($vtUserName="") | ($vtUserName="all@") | ($vtUserName="admin@"))
		$vtUserName:="@"
	End if 
	$vtUserAction:=WCapi_GetParameter("action")
	If (($vtUserAction="") | ($vtUserAction="all@") | ($vtUserAction="admin@"))
		$vtUserAction:="@"
	End if 
	
	
	DateBeginDateEnd(voState.request.parameters)
	//vdDateBegin
	//vdDateBegin
	C_LONGINT:C283($dtBegin_l; $dtEnd_l)
	$dtBegin_l:=DateTime_Enter(vdDateBeg; ?00:00:00?)
	$dtEnd_l:=DateTime_Enter(vdDateEnd; ?23:59:59?)
	
	C_OBJECT:C1216($voSelection)
	$voSelection:=New object:C1471
	C_LONGINT:C283($viDoQuery)
	$viDoQuery:=1
	
	Case of 
		: ($tableName="Contact")
		: ($tableName="Customer")
		: ($tableName="Email")
		: ($tableName="Invoice")
		: ($tableName="Item")
		: ($tableName="Lead")
		: ($tableName="Order")
		: ($tableName="Project")
		: ($tableName="Proposal")
		: ($tableName="PO")
		: ($tableName="Service")
			$viDoQuery:=2
			$voSelection:=ds:C1482.Service.query($vtQuery; $vtUserName; $dtBegin_l; $dtEnd_l; $vtUserAction)
		: ($tableName="CallReport")
			$viDoQuery:=2
			$voSelection:=ds:C1482.CallReport.query($vtQuery; $vtUserName; $dtBegin_l; $dtEnd_l; $vtUserAction)
		: ($tableName="Vendor")
		: ($tableName="WorkOrder")
		Else 
			$viDoQuery:=0
			vResponse:="Error: not a valid Table, "+$tableName
	End case 
	If ($viDoQuery=1)
		$vtQuery:="actionBy = :1 AND actionDate >= :2 AND actionDate <= :3 AND action = :4"
		$voSelection:=ds:C1482[$tableName].query($vtQuery; $vtUserName; vdDateBegin; vdDateEnd; $vtUserAction)
	End if 
	If ($viDoQuery>0)
		$vtRole:="Sales"
		$vtPurpose:="list"
		$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
		vResponse:=API_EntityToText($voSelection; $vtFieldList)
		voState.result:=$tableName+" records in selection: "+String:C10($voSelection.length)
	End if 
End if 