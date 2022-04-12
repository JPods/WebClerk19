//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/06/21, 21:15:32
// ----------------------------------------------------
// Method: WCapiTask_GetGanttVue
// Description
// 
//
// Parameters
// ----------------------------------------------------


ARRAY TEXT:C222($aURL; 0)
C_TEXT:C284($vtUserName; $vtQuery)
C_TEXT:C284($vtFieldList; $vtQuery)
$vtFieldList:="id,company,action,actionBy,actionDate,actionTime,address1,address2,city,state,zip,email,phone,lat,lng,obGeneral.action"
//typeSale,repID,salesNameID,obGeneral.actionOptions,tableName"
DateBeginDateEnd(voState.request.parameters)
If (False:C215)
	If (vdDateBegin=vdDateEnd)
		vdDateBegin:=vdDateBegin-5
		vdDateEnd:=vdDateEnd+25
	End if 
End if 

C_OBJECT:C1216($obRec; $obSel; $obRow)
C_COLLECTION:C1488($cAll; $cTable; $cRow)
$cSelection:=New collection:C1472
If ($vtUserName="all")
	$vtQuery:="ActionDate >= :1 AND ActionDate <= :2"
Else 
	$vtQuery:="ActionDate >= :1 AND ActionDate <= :2 AND ActionBy = :3"
End if 

C_COLLECTION:C1488($cSel)
C_COLLECTION:C1488($cMods; $cOutput)
$cOutput:=New collection:C1472
C_OBJECT:C1216($obRec; $obSel; $obTab; $obTables)
C_OBJECT:C1216($obEmp; $obSelEmp)
C_COLLECTION:C1488($cTables)
$obTables:=New object:C1471
$obTab:=New object:C1471
$obTables.Customer:=New object:C1471("tableName"; "Customer"; "fieldMods"; "customerID")
$obTables.Proposal:=New object:C1471("tableName"; "Proposal"; "fieldMods"; "proposalNum,idCustomer,idContactShip,idContactBill")
$obTables.Order:=New object:C1471("tableName"; "Order"; "fieldMods"; "orderNum,idCustomer,idContactShip,idContactBill")
$obTables.WorkOrder:=New object:C1471("tableName"; "WorkOrders"; "fieldMods"; "woNum,dateEnd,timeEnd,idCustomer")
$obTables.Invoice:=New object:C1471("tableName"; "Invoice"; "fieldMods"; "invoiceNum,idCustomer,idContactShip,idContactBill")
//   $obTables.CallReport:=New object("tableName"; "CallReport"; "fieldMods"; "idNum")
//   $obTables.Service:=New object("tableName"; "Service"; "fieldMods"; "idNum")
$cTables:=New collection:C1472
$cTables.push(New object:C1471("tableName"; "Customer"; "fieldMods"; "customerID"))
$cTables.push(New object:C1471("tableName"; "Proposal"; "fieldMods"; "proposalNum"))
$cTables.push(New object:C1471("tableName"; "Order"; "fieldMods"; "orderNum"))
$cTables.push(New object:C1471("tableName"; "Invoice"; "fieldMods"; "invoiceNum"))
$cTables.push(New object:C1471("tableName"; "WorkOrder"; "fieldMods"; "woNum,dateEnd,timeEnd"))
//$cTables.push(New object("tableName"; "CallReport"; "fieldMods"; "idNum"))
$cTables.push(New object:C1471("tableName"; "Service"; "fieldMods"; "idNum"))

$cOutput:=New collection:C1472
//$obSel:=ds.Proposal.query("actionDate >= "+String(vdDateBegin-10)+" AND actionDate <= "+String(vdDateEnd+10)+"\"")
//$obSel:=ds.Proposal.query("actionDate >= :1 AND actionDate <= :2"; String(vdDateBegin-10); String(vdDateEnd+10))
//$obSel:=ds.Proposal.query("actionDate >= :1 AND actionDate <= :2"; vdDateBegin-10; vdDateEnd+10)



For each ($obTab; $cTables)
	$tableName:=$obTab.tableName
	$obSel:=ds:C1482[$tableName].query("actionDate >= :1 AND actionDate <= :2"; vdDateBegin; vdDateEnd).orderBy("actionDate, actionBy")
	C_TEXT:C284($vtName)
	C_LONGINT:C283($viEmployee)
	
	$tableName:=$obTab.tableName
	If ($obSel.length>0)
		$cSel:=$obSel.toCollection($vtFieldList+","+$obTables[$tableName].fieldMods)
	Else 
		$cSel:=New collection:C1472
	End if 
	C_OBJECT:C1216($obElem)
	C_TEXT:C284($vtTableID)
	For each ($obElem; $cSel)
		$obElem.tableName:=$tableName
		$obElem["id"+$tableName]:=$obElem.id
		
		
		If ($obElem.actionBy="")
			$obElem.actionBy:="unassigned"
		End if 
		$vtName:=$obElem.actionBy
		If ($cOutput.length=0)
			$cOutput.push(New object:C1471("employee"; $vtName; "tasks"; New collection:C1472))
			$viEmployee:=0
		Else 
			//  $viEmployee:=$cOutput.value.employee=$vtName
			$viEmployee:=IndexOf_employee($cOutput; $vtName)
			
		End if 
		If ($viEmployee=-1)
			$cOutput.push(New object:C1471("employee"; $vtName; "tasks"; New collection:C1472))
			$viEmployee:=$cOutput.length-1
		End if 
		
		C_TEXT:C284($vtStartStr; $vtEndStr)
		If ($obElem.tableName="WorkOrder")
			$vtStartStr:=DateTime_Gantt($obElem.actionDate; $obElem.actionTime)
			If ($obElem.dateEnd<$obElem.actionDate)
				$obElem.dateEnd:=$obElem.actionDate
			End if 
			If ($obElem.dateEnd>$obElem.actionDate)
				// leave time alone
			Else 
				If ($obElem.timeEnd<$obElem.actionTime)
					$obElem.timeEnd:=$obElem.actionTime+?01:00:00?
				End if 
			End if 
			$vtEndStr:=DateTime_Gantt($obElem.dateEnd; $obElem.timeEnd)
		Else 
			If ($obElem.obGeneral.events=Null:C1517)
				$obElem.duration:=?01:00:00?  // seconds in an hour
			Else 
				$obElem.events:=$obElem.obGeneral.events
				If ($obElem.events.duration=Null:C1517)  // seconds in an hour
					$obElem.duration:=?01:00:00?  // seconds in an hour
				Else 
					$obElem.duration:=$obElem.events.duration
				End if 
				If (False:C215)  //$obElem.events["1"]#Null)
					//$obElem.duration:=$obElem.events["1"].duration#Null)
					If (False:C215)
						$obElem.duration:=$obElem.events["1"].duration
					End if 
				End if 
			End if 
			$obElem.duration:=($obElem.duration/60)
			$vtStartStr:=DateTime_Gantt($obElem.actionDate; $obElem.actionTime)
			$vtEndStr:=DateTime_Gantt($obElem.actionDate; $obElem.actionTime+($obElem.duration*60))
		End if 
		
		$obElem.actionBegin:=$vtStartStr
		$obElem.actionEnd:=$vtEndStr
		
		If ($obElem.actionDate=Current date:C33)
			$obElem.taskState:="Doing"
		Else 
			$obElem.taskState:="Pending"
		End if 
		//  OB REMOVE($obElem; "id")
		OB REMOVE:C1226($obElem; "obGeneral")
		//OB REMOVE($obElem; "actionDate")
		//OB REMOVE($obElem; "actionTime")
		//C_LONGINT($viIndexOf)
		//$viIndexOf:=$obElem.indexOf("obGeneral")
		//$obElem.remove($viIndexOf)
		//$obElem.obGeneral:=New object
		
		
		
		$cOutput[$viEmployee].tasks.push($obElem)
	End for each 
End for each 
ARRAY TEXT:C222($aNames; 0)
COPY ARRAY:C226(<>ANAMEID; $aNames)
DELETE FROM ARRAY:C228($aNames; 1; 1)
$w:=Find in array:C230($aNames; "Admin")
If ($w>0)
	DELETE FROM ARRAY:C228($aNames; $w; 1)
End if 
$w:=Find in array:C230($aNames; "All Users")
If ($w>0)
	DELETE FROM ARRAY:C228($aNames; $w; 1)
End if 
C_LONGINT:C283($inc; $cnt; $w)
For each ($obEmp; $cOutput)
	$w:=Find in array:C230($aNames; $obEmp.employee)
	If ($w>0)
		DELETE FROM ARRAY:C228($aNames; $w; 1)
	End if 
End for each 
$cnt:=Size of array:C274($aNames)
C_OBJECT:C1216($obEmpty)
For ($inc; 1; $cnt)
	$obEmpty:=New object:C1471
	$obEmpty.employee:=$aNames{$inc}
	$obEmpty.tasks:=New collection:C1472
	$cOutput.push($obEmpty)
End for 

vResponse:=JSON Stringify array:C1228($cOutput)


If (False:C215)
	C_COLLECTION:C1488($cTables)
	$cTables:=$obTables.toCollection()
	C_LONGINT:C283($indexActionBy)
	$obTab:=$cTables.Customer
	For each ($obTab; $cTables)
		$cSel:=New collection:C1472
		$obSel:=ds:C1482[$obTab.tableName].query("actionDate >= :1 AND actionDate <= :2"; String:C10(vdDateBegin-10); String:C10(vdDateEnd+10))
		$obSel:=ds:C1482[$obTab.tableName].query("actionDate >= :1 AND actionDate <= :2"; vdDateBegin-10; vdDateEnd+10)
		$obSel:=ds:C1482[$obTab.tableName].query("actionDate >= :1 AND actionDate <= :2"; vdDateBegin-10; vdDateEnd+10).orderBy(" actionDate, actionBy")
		
		$cSel:=$obSel.toCollection($vtFieldList+","+$obTab[tableName].fieldMods)
		For each ($obElem; $cSel)
			
			$indexActionBy:=$cOutput.indexOf($obElem.actionBy)
			If ($indexActionBy>-1)
			Else 
				$cSel[$obElem.actionBy]:=New collection:C1472
			End if 
			$cSel[$obElem.actionBy].push($obElem)
		End for each 
	End for each 
End if 


If (False:C215)
	C_OBJECT:C1216($obEmployee)
	C_LONGINT:C283($cntOb; $viFound)
	$cntOb:=-1
	$viEmployee:=-1
	For each ($obEmployee; $cOutput) While ($viEmployee=-1)
		$cntOb:=$cntOb+1
		If ($obEmployee.employee=$vtName)
			$viEmployee:=$cntOb
		End if 
	End for each 
End if 