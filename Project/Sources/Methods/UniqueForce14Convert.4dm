//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-04-13T00:00:00, 17:23:35
// ----------------------------------------------------
// Method: UniqueForce14Convert
// Description
// Modified: 04/13/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// Must Run to prepare for Version 14.
C_LONGINT:C283(<>vCounterBuffer)
C_TIME:C306($timeStart; $timeElapsed)
ConsoleLog("ConsoleLaunch")
DELAY PROCESS:C323(Current process:C322; 30)
$timeStart:=Current time:C178
ConsoleLog("Start Time: "+String:C10($timeStart))
C_TEXT:C284($reportText)

C_BOOLEAN:C305($indexed; $isUnique; $isInvisible)
C_LONGINT:C283($typeField; $lenField; $numField)
C_LONGINT:C283($incRecord; $cntRecords; $incTables; $cntTables; $rportRecord)
C_TEXT:C284($tableName)
C_TEXT:C284($logOfChanges)

C_LONGINT:C283($maxValue)

C_LONGINT:C283($1; $forceNew)
$forceNew:=1
If (Count parameters:C259=1)
	$forceNew:=$1
End if 

$reportText:=""
vText2:=""
$cntTables:=Get last table number:C254

For ($incTables; 1; $cntTables)
	$tableName:=Table name:C256($incTables)
	
	//  If ((vText1="Counter@") | (vText1="zz@") | (vText1="(@") | (vText1="Default"))
	
	If (($tableName="zz@") | ($tableName="(@"))
		// ALL RECORDS(Table($incTables)->)
		// DELETE SELECTION(Table($incTables)->)
	Else 
		UniqueBySequence($incTables)
	End if 
End for 
ConsoleLog("Completed duration: "+String:C10(Current time:C178-$timeStart))

SelectionToZero

