//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/24/21, 10:58:59
// ----------------------------------------------------
// Method: WCapiTask_GetBy
// Description
// 
//
// Parameters
// ----------------------------------------------------
//voState.url:=Substring(voState.url; 2)  // clip the leading /
//voState.url:=Substring(voState.url; Position("/"; voState.url)+1)  // clip the GetBy/

C_TEXT:C284($tableName; $vtFieldName; $vtValue)
WCapil_TableFieldvoState
If (voState.working.fieldName=Null:C1517)
	// test tableName or fieldName depending
	// fieldName is more restrictive
Else 
	$tableName:=voState.working.tableName
	$vtFieldName:=voState.working.fieldName
	C_LONGINT:C283($tableNum; $fieldNum)
	$ptField:=STR_GetFieldPointer($tableName; $vtFieldName)
	C_TEXT:C284($vtValue; $vtContains; $vtExact; $vtType)
	$vtValue:=WCapi_GetParameter("value")
	
	Case of 
		: (Type:C295($ptField->)=Is longint:K8:6)
			$veSelection:=ds:C1482[$tableName].query($vtFieldName+" = :1 "; Num:C11($vtValue))
		: (Type:C295($ptField->)=Is date:K8:7)
			$veSelection:=ds:C1482[$tableName].query($vtFieldName+" = :1 "; Date:C102($vtValue))
		: (Type:C295($ptField->)=Is time:K8:8)
			$veSelection:=ds:C1482[$tableName].query($vtFieldName+" = :1 "; Time:C179($vtValue))
		: ((Type:C295($ptField->)=Is text:K8:3) | (Type:C295($ptField->)=Is alpha field:K8:1))
			$vtExact:=WCapi_GetParameter("exact")
			$vtContains:=WCapi_GetParameter("contains")
			If (($vtExact="1") | ($vtExact="t@"))
				$vtContains:=""
			Else 
				$vtValue:=$vtValue+"@"
			End if 
			If (($vtContains="1") | ($vtContains="t@"))
				$vtValue:="@"+$vtValue
			End if 
			$veSelection:=ds:C1482[$tableName].query($vtFieldName+" = :1 "; $vtValue)
		Else 
			vResponse:="Error: this type of field is not accessible by this command: +"
	End case 
	
	C_OBJECT:C1216($veSelection)
	
	$vtRole:="Sales"
	$vtPurpose:="list"
	$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
	vResponse:=API_EntityToText($veSelection; $vtFieldList)
	voState.result:=$tableName+" records in selection: "+String:C10($veSelection.length)
End if 

