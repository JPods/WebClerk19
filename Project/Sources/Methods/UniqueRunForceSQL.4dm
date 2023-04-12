//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-04-12T00:00:00, 21:36:01
// ----------------------------------------------------
// Method: UniqueRunForceSQL
// Description
// Modified: 04/12/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_TIME:C306($timeStart; $timeElapsed)
$timeStart:=Current time:C178

If (False:C215)  // already run to create the id field
	
	ConsoleLog("ConsoleLaunch")
	
	C_LONGINT:C283($i; $k; $cntRecords)
	C_POINTER:C301($ptTable)
	C_TEXT:C284($tableName; $textCommand)
	
	$k:=Get last table number:C254
	For ($i; 1; $k)
		$ptTable:=Table:C252($i)
		$tableName:=Table name:C256($i)
		ALL RECORDS:C47($ptTable->)
		If (($tableName="zz@") | ($tableName="(@"))
			// DELETE SELECTION($ptTable->)
		Else 
			$cntRecords:=Records in selection:C76($ptTable->)
			REDUCE SELECTION:C351($ptTable->; 0)
			ConsoleLog($tableName+": records "+String:C10($cntRecords))
			$textCommand:="EXECUTE FORMULA("+Char:C90(Double quote:K15:41)+"SET INDEX(["+$tableName+"]id;true)"+Char:C90(Double quote:K15:41)+")"
			ExecuteText(0; $textCommand)
		End if 
	End for 
	ConsoleLog("Complete: "+String:C10(Current time:C178-$timeStart))
	
End if 