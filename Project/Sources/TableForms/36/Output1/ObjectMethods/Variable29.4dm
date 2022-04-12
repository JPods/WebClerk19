// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-02T00:00:00, 01:05:42
// ----------------------------------------------------
// Method: [dInventory].Output.Variable29
// Description
// Modified: 01/02/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

//if(false)

//
// ALL RECORDS([People])
//  //Allow the user to sort the selection
// ORDER BY([People])
//  // Save the sorted selection as a named selection
// COPY NAMED SELECTION([People];"UserSort")
//  // Search for records where invoices are due
// QUERY([People];[People]InvoiceDue=True)
//  // If records are found
// If(Records in selection([People])>0)
//  // Alert the user
//    ALERT("Yes, there are overdue invoices on table.")
// End if
//  // Reuse the sorted named selection
// USE NAMED SELECTION("UserSort")
//  // Remove the selection from memory
// CLEAR NAMED SELECTION("UserSort")

ON ERR CALL:C155("jOECNoAction")

C_LONGINT:C283($1; $tableNum)
C_POINTER:C301($ptTable)
C_TEXT:C284($nameOfSelection)
If (Count parameters:C259>0)
	$tableNum:=$1
	If (Count parameters:C259>1)
		$nameOfSelection:=$2
	Else 
		
	End if 
Else 
	$tableNum:=Table:C252(ptCurTable)
End if 



C_TEXT:C284($tableName)
C_LONGINT:C283($cntRecords)
$nameOfSelection:=tableName+"_"+String:C10([EventLog:75]idNum:5)
$ptTable:=(->[DInventory:36])
$tableName:=Table name:C256($ptTable)
COPY NAMED SELECTION:C331($ptTable->; $nameOfSelection)
$cntRecords:=Records in selection:C76($ptTable->)
ARRAY LONGINT:C221(aAbsoluteRecordNum; 0)
LONGINT ARRAY FROM SELECTION:C647($ptTable->; aAbsoluteRecordNum; $nameOfSelection)

CLEAR NAMED SELECTION:C333($nameOfSelection)

NamedArrayToText(->aAbsoluteRecordNum; ->vText1)
CREATE RECORD:C68([GenericChild2:91])

[GenericChild2:91]tableNum:42:=Table:C252($ptTable)
[GenericChild2:91]purpose:4:="NamedSelection"
[GenericChild2:91]name:3:=$nameOfSelection
[GenericChild2:91]t01:32:=vText1
[GenericChild2:91]dtLastSync:45:=DateTime_Enter
SAVE RECORD:C53([GenericChild2:91])

$cntRecords:=Records in selection:C76([DInventory:36])
REDUCE SELECTION:C351([DInventory:36]; 2)
$cntRecords:=Records in selection:C76([DInventory:36])

NamedArrayFromText(->aAbsoluteRecordNum; ->vText1)

CREATE SELECTION FROM ARRAY:C640($ptTable->; aAbsoluteRecordNum)
// end if
ON ERR CALL:C155("")