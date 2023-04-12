//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/03/21, 01:01:28
// ----------------------------------------------------
// Method: Roles_Startup
// Description
// 
// Creates an object with the available fields by Role and by "list" and "form"
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($voLists)
C_OBJECT:C1216($voRec)
C_OBJECT:C1216($vEntFieldChars)
C_TEXT:C284($tableName)

C_OBJECT:C1216($voFormFields)
C_OBJECT:C1216($voListFields)
C_LONGINT:C283($incSel; $cntSel)
$vEntFieldChars:=ds:C1482.FC.query("purpose = @List@")

If ($vEntFieldChars.length=0)
	//WCapi_FieldList_Create
End if 

// MustFixQQQZZZ: Bill James (2021-11-17T06:00:00Z)
// Rework this entire thing  -  Simplify 
ARRAY OBJECT:C1221(aObRoleAccess; 0)
C_OBJECT:C1216($voSelEmployees)
C_COLLECTION:C1488($vcDistinctRoles)
C_TEXT:C284($vtRole)

// build a list of employee roles
$voSelEmployees:=ds:C1482.Employee.query("role # '' ")
$vcRoles:=$voSelEmployees.role
$vcDistinctRoles:=$vcRoles.distinct()
C_OBJECT:C1216(voFieldsByRole)
voFieldsByRole:=New object:C1471
C_TEXT:C284($vtRework)
//TRACE
For each ($vtRole; $vcDistinctRoles)
	$voFormFields:=New object:C1471
	$voListFields:=New object:C1471
	$vEntFieldChars:=ds:C1482.FC.query("purpose = :1 "; "@List_"+$vtRole)
	For each ($voRec; $vEntFieldChars)  // loop through the List records
		$tableName:=$voRec.tableName
		If ($voRec.obGeneral.data#Null:C1517)
			$voFormFields[$tableName]:=New object:C1471
			If (Position:C15("id"; $voRec.obGeneral.data)<1)
				$voRec.obGeneral.data:="id,"+$voRec.obGeneral.data
				$result_o:=$voRec.save()
			End if 
			If (Position:C15("id"; $voRec.obGeneral.list)<1)
				$voRec.obGeneral.list:="id,"+$voRec.obGeneral.list
				$result_o:=$voRec.save()
			End if 
			$voFormFields[$tableName]:=$voRec.obGeneral.data
			$voListFields[$tableName]:=New object:C1471
			$voListFields[$tableName]:=$voRec.obGeneral.list
			//$voFormFields[$tableName]:=$voRec.obGeneral.data
		End if 
	End for each 
	voFieldsByRole[$vtRole]:=New object:C1471
	voFieldsByRole[$vtRole].list:=$voListFields
	voFieldsByRole[$vtRole].form:=$voFormFields
End for each 

$vEntFieldChars:=ds:C1482.FC.query("purpose = :1 "; "minRole")
If ($vEntFieldChars.length=0)
	$vtTables:="Customers,Contacts,Orders,OrderLines,Invoices,InvoiceLines,Payments,Ledgers,Items;Proposals;ProposalLines;RemoteUsers,Objectives,Projects,WorkOrders,QAQuestions,QAAnswers;QACustomers,Service"
	//TRACE
	
	//WCapi_FieldList_Create("minRole";$vtTables;1)
Else 
	For each ($voRec; $vEntFieldChars)
		$tableName:=$voRec.tableName
		$voFormFields[$tableName]:=New object:C1471
		$voFormFields[$tableName]:=$voRec.obGeneral.data
		$voListFields[$tableName]:=New object:C1471
		$voListFields[$tableName]:=$voRec.obGeneral.list
		//$voFormFields[$tableName]:=$voRec.obGeneral.data
	End for each 
	voFieldsByRole.minRole:=New object:C1471
	voFieldsByRole.minRole.list:=$voListFields
	voFieldsByRole.minRole.form:=$voFormFields
End if 