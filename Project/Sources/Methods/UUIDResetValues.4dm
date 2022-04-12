//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-30T00:00:00, 20:59:37
// ----------------------------------------------------
// Method: UUIDResetValues
// Description
// Modified: 07/30/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptUUIDField; $ptTable)
C_LONGINT:C283($cntTables; $incTables; $cntRecords; $milliUUID; $milliIndex; $milliseconds)
C_LONGINT:C283($uuidFieldNum)
C_TEXT:C284($tableName)

If (Count parameters:C259=0)
	ConsoleMessage("ConsoleLaunch")
	$cntTables:=Get last table number:C254
	For ($incTables; 1; $cntTables)
		$tableName:=Table name:C256($incTables)
		If (($tableName="zz@") | ($tableName="(@"))
			// do nothing
		Else 
			$ptTable:=Table:C252($incTables)
			$uuidFieldNum:=UUIDFieldNum($ptTable)
			$ptUUIDField:=Field:C253($incTables; $uuidFieldNum)
			// ALL RECORDS($ptTable->)
			// Modified by: Bill James (2017-05-22T00:00:00)
			// never change already existing UUIDs
			QUERY:C277($ptTable->; $ptUUIDField->="")
			$cntRecords:=Records in selection:C76($ptTable->)
			If ($cntRecords>0)
				$milliseconds:=Milliseconds:C459
				APPLY TO SELECTION:C70($ptTable->; $ptUUIDField->:=Generate UUID:C1066)
				$milliUUID:=Milliseconds:C459
				UNLOAD RECORD:C212($ptTable->)
				SET INDEX:C344($ptUUIDField->; False:C215)
				SET INDEX:C344($ptUUIDField->; True:C214)
				$milliIndex:=Milliseconds:C459
				
				$milliIndex:=$milliIndex-$milliUUID
				$milliUUID:=$milliUUID-$milliseconds
				ConsoleMessage($tableName+" ResetUUID records: "+String:C10($cntRecords)+", UUID: "+String:C10($milliUUID)+", Reindex: "+String:C10($milliIndex)+"\r")
				FLUSH CACHE:C297
			End if 
		End if 
	End for 
	ConsoleMessage("All Records in All tables have UUIDs"+"\r")
Else 
	$ptUUIDField:=$1
	$ptTable:=Table:C252(Table:C252($ptUUIDField))
	ALL RECORDS:C47($ptTable->)
	
	APPLY TO SELECTION:C70($ptTable->; $ptUUIDField->:=Generate UUID:C1066)
	FLUSH CACHE:C297
	UNLOAD RECORD:C212($ptTable->)
	SET INDEX:C344($ptUUIDField->; False:C215)
	SET INDEX:C344($ptUUIDField->; True:C214)
End if 