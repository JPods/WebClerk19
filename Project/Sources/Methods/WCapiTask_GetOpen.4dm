//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/30/20, 16:41:53
// ----------------------------------------------------
// Method: WCapiTask_GetOpen
// Description

ARRAY TEXT:C222($aURL; 0)
TextToArray(voState.url; ->$aURL; "/")
If (Size of array:C274($aURL)#2)
	vResponse:="Error: improper data for GetOpen, requires /WCapi/tableName: "+voState.url
Else 
	C_POINTER:C301($ptTable; $ptField)
	$ptTable:=STR_GetTablePointer($aURL{1})
	If (Is nil pointer:C315($ptTable))
		vResponse:="Error: tableName invalid in GetOpen: "+$aURL{1}
	Else 
		$tableName:=Table name:C256($ptTable)
		$vbDoOpen:=True:C214
		vResponse:="[]"
		Case of 
			: ($tableName="Proposal")
				$veSelection:=ds:C1482[$tableName].query("complete = False")
			: ($tableName="Order")
				$veSelection:=ds:C1482[$tableName].query("complete < 2 ")
			: ($tableName="Invoice")
				$veSelection:=ds:C1482[$tableName].query("balanceDue # 0 ")
			: ($tableName="PO")
				$veSelection:=ds:C1482[$tableName].query("complete < 2 ")
			Else 
				$vbDoOpen:=False:C215
				vResponse:="Error: GetOpen does not apply: +$tableName"
		End case 
		If ($vbDoOpen)
			C_OBJECT:C1216($veSelection)
			
			$vtRole:="Sales"
			$vtPurpose:="list"
			$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
			vResponse:=API_EntityToText($veSelection; $vtFieldList)
			voState.result:=$tableName+" records in selection: "+String:C10($veSelection.length)
		End if 
	End if 
End if 