//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/29/18, 10:15:48
// ----------------------------------------------------
// Method: Ltr_TinyMCE
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_POINTER:C301($1; $2; $ptTable; ptCurTable)
ARRAY LONGINT:C221(aiRecordNums; 0)

If (ptCurTable=(->[Base:1]))
	ALERT:C41("Letters must be lauched from Input or Output Layouts.")
Else 
	If (Count parameters:C259<2)
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		C_LONGINT:C283($curRecordNum)
		$curRecordNum:=-1
		If (vHere>1)
			AcceptPrint
			$curRecordNum:=Record number:C243(ptCurTable->)
		End if 
		SELECTION TO ARRAY:C260(ptCurTable->; aiRecordNums)
		<>processAlt:=New process:C317("Ltr_TinyMCE"; <>tcPrsMemory; "Letters: "+Table name:C256(ptCurTable); ptCurTable; ->aiRecordNums)
		Repeat 
			DELAY PROCESS:C323(Current process:C322; 10)
		Until (<>prcControl=0)
		If ($curRecordNum>-1)
			GOTO RECORD:C242(ptCurTable->; $curRecordNum)
		End if 
	Else 
		C_LONGINT:C283($i)
		C_POINTER:C301($ptVar)
		ptPrintTable:=$1
		ARRAY LONGINT:C221(aiRecordNums; 0)
		COPY ARRAY:C226($2->; aiRecordNums)
		<>prcControl:=0
		Process_InitLocal
		ptCurTable:=(->[Base:1])
		ControlRecCheck
		
		FORM SET INPUT:C55([Base:1]; "LetterWrite")
		//jSetMenuNums (1;5;6)
		SRPage:=1
		
		Open window:C153(10; 40; 820; 734; 8; "Letters: "+Table name:C256(ptPrintTable))
		ptCurTable:=(->[Base:1])
		ProcessTableOpen(->[Base:1]; "skip")
		POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
	End if 
End if 



