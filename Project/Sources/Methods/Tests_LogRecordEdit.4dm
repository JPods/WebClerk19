//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/05/19, 07:34:26
// ----------------------------------------------------
// Method: Tests_LogRecordEdit
// Description
// 
//
// Parameters
// ----------------------------------------------------

// LOAD TEST RECORDS

QUERY:C277([Employee:19]; [Employee:19]nameID:1="amercer")
QUERY:C277([Customer:2]; [Customer:2]company:2="7.9. Design")

// SET UP VALUES TO FILL OUT CHANGELOG RECORD

C_TEXT:C284($vtLinkedTableName; $vtLinkedUniqueID; $vtAuthorTableName; $vtAuthorUniqueID; $vtFieldName; $vtValueOriginal; $vtValueChanged; $vtCustomChangeDesc; $vtKeyText)
$vtLinkedTableName:="Customer"
$vtLinkedUniqueID:=String:C10([Customer:2]customerID:1)
$vtAuthorTableName:="Employees"
$vtAuthorUniqueID:=String:C10([Employee:19]idNum:71)
$vtFieldName:="City"
$vtValueOriginal:="Westfield"
$vtValueChanged:="Carmel"
$vtCustomChangeDesc:=""
$vtKeyText:="CreatedByAutomatedTesting"

C_LONGINT:C283($viUniqueID)

// ADD CHANGELOG

$viUniqueID:=LogRecordEdit($vtLinkedTableName; $vtLinkedUniqueID; $vtAuthorTableName; $vtAuthorUniqueID; $vtFieldName; $vtValueOriginal; $vtValueChanged; $vtCustomChangeDesc; $vtKeyText)

// LOAD CHANGELOG WE JUST CREATED

QUERY:C277([ChangeLog:149]; [ChangeLog:149]idNum:1=$viUniqueID)

// TEST EVERY VALUE TO MAKE SURE RECORD WAS PROPERLY FILLED OUT

C_BOOLEAN:C305($0)
$0:=True:C214

If ($vtLinkedTableName#[ChangeLog:149]linkedTableName:2)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]LinkedTableName wasn't set properly.")
	
End if 

If ($vtLinkedUniqueID#[ChangeLog:149]ideLinked:3)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]LinkedUniqueID wasn't set properly.")
	
End if 

If ($vtAuthorTableName#[ChangeLog:149]authorTableName:9)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]AuthorTableName wasn't set properly.")
	
End if 

If ($vtAuthorUniqueID#[ChangeLog:149]nameIDAuthor:8)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]AuthorUniqueID wasn't set properly.")
	
End if 

If ($vtFieldName#[ChangeLog:149]fieldName:10)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]FieldName wasn't set properly.")
	
End if 

If ($vtValueOriginal#[ChangeLog:149]valueOriginal:4)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]ValueOriginal wasn't set properly.")
	
End if 

If ($vtValueChanged#[ChangeLog:149]valueChanged:11)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]ValueChanged wasn't set properly.")
	
End if 

If ($vtCustomChangeDesc#[ChangeLog:149]customChangeDesc:7)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]CustomChangeDesc wasn't set properly.")
	
End if 

If ($vtKeyText#[ChangeLog:149]keyTags:13)
	
	$0:=False:C215
	ConsoleLog("Tests_LogRecordEdit: [Changelog]KeyText wasn't set properly.")
	
End if 

DELETE RECORD:C58([ChangeLog:149])
ALL RECORDS:C47([ChangeLog:149])
SET DATABASE PARAMETER:C642([ChangeLog:149]; Table sequence number:K37:31; Records in selection:C76([ChangeLog:149]))