//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/18, 08:22:17
// ----------------------------------------------------
// Method: TestOutPutLayouts
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($inc; $cnt; $cntRecs; $startNum)
C_POINTER:C301($ptTable)
C_TEXT:C284($tableName)
// $startNum=num(request("Start number";"1"))

C_LONGINT:C283(<>viiLoWindowWidth; <>viiLoWindowHeight)
C_BOOLEAN:C305(<>vbForceWindowStandard)
<>viiLoWindowWidth:=1020
<>viiLoWindowHeight:=710
<>vbForceWindowStandard:=True:C214

// If (False)  // only for development
$startNum:=121
$cnt:=Size of array:C274(<>aTableNames)
$cnt:=40+$startNum
If ($cnt>Size of array:C274(<>aTableNames))
	$cnt:=Size of array:C274(<>aTableNames)
End if 
For ($inc; $startNum; $cnt)
	$ptTable:=Table:C252(<>aTableNums{$inc})
	$tableName:=Table name:C256(<>aTableNums{$inc})
	If (($tableName#"z@") & ($tableName#"(@"))  // should alread by taken care of by 
		If (($tableName#"Control") & ($tableName#"Default"))
			ALL RECORDS:C47($ptTable->)
			
			If (Records in selection:C76($ptTable->)<2)
				CREATE RECORD:C68($ptTable->)
				SAVE RECORD:C53($ptTable->)
				CREATE RECORD:C68($ptTable->)
				SAVE RECORD:C53($ptTable->)
				ALL RECORDS:C47($ptTable->)
			End if 
			
			$cntRecs:=Records in selection:C76($ptTable->)
			ConsoleMessage($tableName+": "+String:C10($cntRecs))
			If ($cntRecs>0)
				ProcessTableOpen(<>aTableNums{$inc})
			End if 
			DELAY PROCESS:C323(Current process:C322; 30)
			
			
			If (Caps lock down:C547)
				TRACE:C157
			End if 
		End if 
	End if 
End for 
// End if 


If (False:C215)
	$startNum:=1
	$cnt:=Size of array:C274(<>aTableNames)
	For ($inc; $startNum; $cnt)
		$ptTable:=Table:C252(<>aTableNums{$inc})
		$tableName:=Table name:C256(<>aTableNums{$inc})
		If (($tableName#"z@") & ($tableName#"(@"))
			ALL RECORDS:C47($ptTable->)
			$cntRecs:=Records in selection:C76($ptTable->)
			ConsoleMessage(Table name:C256(<>aTableNums{$inc})+": "+String:C10($cntRecs))
			If ($cntRecs>0)
				ProcessTableOpen(<>aTableNums{$inc})
			Else 
				ConsoleMessage(Table name:C256(<>aTableNums{$inc})+": ATTN Zero Records")
			End if 
			DELAY PROCESS:C323(Current process:C322; 90)
			
			
			If (Caps lock down:C547)
				TRACE:C157
			End if 
		End if 
	End for 
End if 
