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
	: (process_o.tableName#Null:C1517)
		$tableName:=process_o.tableName
		$tableNum:=ds:C1482[$tableName].getInfo().tableNumber
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
$tableName:=Table name:C256($tableNum)
$ptCurTable:=Table:C252($tableNum)

If (((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On After Keystroke:K2:26) | (Count parameters:C259>=2)) & (Length:C16(srKeyword)>1))  // add timer
	
	// cleanup and feed back out the srKeyword
	
	ARRAY TEXT:C222($atMyKeywords; 0)
	srKeyword:=KeyWordCleanup(srKeyword; ->$atMyKeywords)
	$countWords:=Size of array:C274($atMyKeywords)
	
	If ($countWords>0)
		C_LONGINT:C283(<>viUseCurrentSelection)
		If ((<>viUseCurrentSelection=0) | (($vbSearchAll=True:C214) & (Not:C34(Shift down:C543))) | (Records in selection:C76($ptCurTable->)=0))
			ALL RECORDS:C47($ptCurTable->)
		End if 
		
		KeyWordByTag($tableName; srKeyword)
		Case of 
			: (process_o.form=Null:C1517)
				SET WINDOW TITLE:C213($tableName+":  "+String:C10(Records in selection:C76($ptCurTable->))+" - "+Storage:C1525.default.company)
				// ### jwm ### 20181002_1311 return to srKeyword at end of string
				$vLen:=Length:C16(srKeyword)+1
				HIGHLIGHT TEXT:C210(srKeyword; $vLen; $vLen)
			: (process_o.form="OutputDS")
				Form:C1466.ents:=Create entity selection:C1512(ptCurTable->)
				SET WINDOW TITLE:C213($tableName+":  "+String:C10(Records in selection:C76($ptCurTable->))+" - "+Storage:C1525.default.company)
				REDUCE SELECTION:C351(ptCurTable->; 0)
				process_o.ents:=Form:C1466.ents
			: (process_o.queryReturn="entity")
				Form:C1466.ents:=Create entity selection:C1512(ptCurTable->)
				SET WINDOW TITLE:C213($tableName+":  "+String:C10(Records in selection:C76($ptCurTable->))+" - "+Storage:C1525.default.company)
				REDUCE SELECTION:C351(ptCurTable->; 0)
			: (vHere=1)
				SET WINDOW TITLE:C213($tableName+":  "+String:C10(Records in selection:C76($ptCurTable->))+" - "+Storage:C1525.default.company)
				// ### jwm ### 20181002_1311 return to srKeyword at end of string
				$vLen:=Length:C16(srKeyword)+1
				HIGHLIGHT TEXT:C210(srKeyword; $vLen; $vLen)
		End case 
		
	End if 
End if 
