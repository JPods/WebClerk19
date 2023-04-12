//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/17/20, 01:15:20
// ----------------------------------------------------
// Method: KeyWordByAlpha
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284(srKeyword)
C_LONGINT:C283($1; $tableNum; $incKeywords; $countKeywords; $length)
C_LONGINT:C283($testTime)
C_POINTER:C301($ptCurTable)
C_BOOLEAN:C305($vbSearchAll)
C_TEXT:C284($tableName; $myKeyWords; $2)
$testTime:=Milliseconds:C459
//$myKeyWords:=srKeyword  // iLoSearch
$myKeyWords:=""
$vbSearchAll:=True:C214
Case of 
	: (process_o.dataClassName#Null:C1517)
		$tableName:=process_o.dataClassName
		//$tableNum:=ds[$tableName].getInfo().tableNumber
		If (process_o.dataClassPtr=Null:C1517)
			process_o.dataClassPtr:=STR_GetTablePointer($tableName)
		End if 
		$ptCurTable:=process_o.dataClassPtr
		$tableNum:=Table:C252(process_o.dataClassPtr)
	: (Count parameters:C259>0)
		$tableNum:=$1
		If (Count parameters:C259>1)
			srKeyword:=$2
			If (Count parameters:C259>2)
				$vbSearchAll:=$3
			End if 
		End if 
	: (ptCurTable#Null:C1517)
		$tableNum:=Table:C252(ptCurTable)
	Else 
		$tableNum:=ds:C1482["Customer"].getInfo().tableNumber
End case 


If (((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On After Keystroke:K2:26) | (Count parameters:C259>=2)) & (Length:C16(srKeyword)>1))  // add timer
	
	// cleanup and feed back out the srKeyword
	
	ARRAY TEXT:C222($atMyKeywords; 0)
	srKeyword:=KeyWordCleanup(srKeyword)
	$countWords:=Size of array:C274($atMyKeywords)
	
	If ($countWords>0)
		READ ONLY:C145($ptCurTable->)
		C_LONGINT:C283(<>viUseCurrentSelection)
		If ((<>viUseCurrentSelection=0) | (($vbSearchAll=True:C214) & (Not:C34(Shift down:C543))) | (Records in selection:C76($ptCurTable->)=0))
			ALL RECORDS:C47($ptCurTable->)
		End if 
		
		KeyWordByTag($tableName; srKeyword)
		process_o.ents:=Create entity selection:C1512((process_o.dataClassPtr)->)
		
		READ WRITE:C146($ptCurTable->)
		REDUCE SELECTION:C351($ptCurTable->; 0)
		
		//QQQ Make this a class function
		//var $o : Object
		//$o:=process_o.selectChanged()
		entry_o:=process_o.selectChanged()
		
	End if 
End if 
