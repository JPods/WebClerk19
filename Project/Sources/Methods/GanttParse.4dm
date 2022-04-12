//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/25/18, 18:49:08
// ----------------------------------------------------
// Method: GanttParse
// Description
// 
//
// Parameters
// ----------------------------------------------------

//{
//"id": [WorkOrder]WONum,
//"name": "[WorkOrder]Title",
//"progress": [WorkOrder]FlowProgress,
//"progressByWorklog": [WorkOrder]FlowProgressByWorklog,
//"description": "[WorkOrder]Description",
//"code": "[WorkOrder]FlowCode",
//"level": [WorkOrder]FlowLevel,
//"status": "[WorkOrder]Status",
//"depends": "FlowDepends",
//"start": _jit_0_dtEpochPlannedjj,
//"duration": [WorkOrder]DurationPlanned,
//"end": _jit_0_dtEpochEndPlanjj,
//"startIsMilestone": [WorkOrder]FlowStartIsMilestone,
//"endIsMilestone": [WorkOrder]FlowEndIsMilestone,
//"collapsed": [WorkOrder]FlowCollapsed,
//"canWrite": [WorkOrder]FlowCanWrite,
//"canAdd": [WorkOrder]FlowCanAdd,
//"canDelete": [WorkOrder]FlowCanDelete,
//"canAddIssue": [WorkOrder]FlowCanIssue,  
//"hasChild": [WorkOrder]FlowHasChildren,
//"assigs": [
//{
//"id": "tmp_1545589986961_1",
//"resourceId": "tmp_3",
//"roleId": "tmp_1",
//"effort": 799200000
//}
//]
//}

C_OBJECT:C1216($voBatch)
C_LONGINT:C283(vlObjLevel)
C_OBJECT:C1216($voTemp)
ARRAY OBJECT:C1221($aoTemp; 0)

C_TEXT:C284($jsIncoming; $1)
If (Count parameters:C259=1)
	$jsIncoming:=$1
Else 
	$jsIncoming:=Get text from pasteboard:C524
End if 
//
$jsIncoming:=Replace string:C233($jsIncoming; "\\n"; "")  // worked

C_TEXT:C284(dtEpochPlanned; dtEpochEndPlan)
C_BOOLEAN:C305($doWO)
C_LONGINT:C283($woNum)
//

$voBatch:=JSON Parse:C1218($jsIncoming)

OB GET ARRAY:C1229($voBatch; "tasks"; $aoTemp)
If (Size of array:C274($aoTemp)>0)
	C_LONGINT:C283($incRay; $cntRay)
	$cntRay:=Size of array:C274($aoTemp)
	// ### bj ### 20190428_1814
	C_LONGINT:C283($viSequenceNum)
	$viSequenceNum:=0
	For ($incRay; 1; $cntRay)
		$viSequenceNum:=$viSequenceNum+1
		$doWO:=False:C215
		$voTemp:=$aoTemp{$incRay}
		C_LONGINT:C283($tmpIDLong)
		C_LONGINT:C283($viType)
		C_TEXT:C284($tmpIDText)
		$tmpIDText:=OB Get:C1224($voTemp; "id")
		Case of 
			: ($tmpIDText="tmp@")
				REDUCE SELECTION:C351([WorkOrder:66]; 0)
				$doWO:=True:C214
			: ($tmpIDText="WO-@")
				$tmpIDText:=Substring:C12($tmpIDText; 4)  // clip to number
				$woNum:=Num:C11($tmpIDText)
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=$woNum)
				$doWO:=True:C214
			Else 
				$doWO:=False:C215  // PO or SaleOrder
		End case 
		If ($doWO)
			GanttRecordInOut("WorkOrder"; "in"; ->$voTemp; [Project:24]projectNum:1; $viSequenceNum)
		End if 
	End for 
End if 
// deleted records


C_TEXT:C284($vtToDelete)
ARRAY TEXT:C222($atDeleted; 0)
OB GET ARRAY:C1229($voBatch; "deletedtaskIDs"; $atDeleted)
If (Size of array:C274($atDeleted)>0)
	C_LONGINT:C283($incRay; $cntRay)
	$cntRay:=Size of array:C274($atDeleted)
	For ($incRay; 1; $cntRay)
		$vtToDelete:=$atDeleted{$incRay}
		C_LONGINT:C283($tmpIDLong)
		C_LONGINT:C283($viType)
		C_TEXT:C284($tmpIDText)
		$tmpIDText:=OB Get:C1224($voTemp; "id")
		Case of 
			: ($vtToDelete="tmp@")
			: ($vtToDelete="WO-@")
				$vtToDelete:=Substring:C12($vtToDelete; 4)  // clip to number
				$woNum:=Num:C11($vtToDelete)
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=$woNum)
				DELETE RECORD:C58([WorkOrder:66])
			Else 
				$doWO:=False:C215  // PO or SaleOrder
		End case 
	End for 
End if 
