//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/25/19, 10:48:59
// ----------------------------------------------------
// Method: Util_InputLayoutTest
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($tableNum; $uniqueFieldNum; $tableNum; $cntTables)
C_TEXT:C284($tableName; $uniqueFieldName)
C_POINTER:C301($ptTable; $ptArray; $ptUniqueField; $ptField)
C_TEXT:C284($fieldName)
C_LONGINT:C283($i; $k; $loopTable)
$cntTables:=Get last table number:C254
Process_InitLocal
WindowOpenTaskOffSets
C_LONGINT:C283($startTable)
$startTable:=Num:C11(Request:C163("Start with TableNum?"; "2"))
If ($startTable>1)
	CONFIRM:C162("Input or OutPut Layouts?"; "Input"; "OutPut")
	If (OK=1)
		
		$loopTable:=0
		For ($tableNum; $startTable; $cntTables)  //  Tables  
			If (Is table number valid:C999($tableNum))
				Repeat 
					If ($loopTable=0)
						$tableName:=Table name:C256($tableNum)
						$ptTable:=Table:C252($tableNum)
						$cntRecords:=Records in table:C83($ptTable->)
						
						curTableNum:=$tableNum
						ptCurTable:=$ptTable
					End if 
					
					Case of 
						: ($tableName="(@")
						: ($tableName="zz@")  // this also excludes the window database
						: ($tableName="Control@")  // this also excludes the window database
						Else 
							READ WRITE:C146($ptTable->)
							If ($cntRecords=0)
								ADD RECORD:C56($ptTable->)
							Else 
								ALL RECORDS:C47($ptTable->)
								REDUCE SELECTION:C351($ptTable->; 1)
								MODIFY RECORD:C57($ptTable->)
							End if 
							REDUCE SELECTION:C351($ptTable->; 0)
					End case 
					If (Caps lock down:C547)
						$loopTable:=1
						TRACE:C157
					Else 
						$loopTable:=0
					End if 
				Until ($loopTable=0)
			End if 
		End for 
	Else 
		
		$loopTable:=0
		For ($tableNum; $startTable; $cntTables)  //  Tables  
			If (Is table number valid:C999($tableNum))
				Repeat 
					If ($loopTable=0)
						$tableName:=Table name:C256($tableNum)
						$ptTable:=Table:C252($tableNum)
						$cntRecords:=Records in table:C83($ptTable->)
						
						curTableNum:=$tableNum
						ptCurTable:=$ptTable
					End if 
					
					Case of 
						: ($tableName="(@")
						: ($tableName="zz@")  // this also excludes the window database
						: ($tableName="Control@")  // this also excludes the window database
						Else 
							READ WRITE:C146($ptTable->)
							ALL RECORDS:C47($ptTable->)
							If ($cntRecords=0)
								ADD RECORD:C56($ptTable->)
								SAVE RECORD:C53($ptTable->)
								ADD RECORD:C56($ptTable->)
								SAVE RECORD:C53($ptTable->)
							Else 
								REDUCE SELECTION:C351($ptTable->; 10)
							End if 
							WindowOpenTaskOffSets
							MODIFY SELECTION:C204($ptTable->)
							REDUCE SELECTION:C351($ptTable->; 0)
					End case 
					If (Caps lock down:C547)
						$loopTable:=1
					Else 
						$loopTable:=0
					End if 
				Until ($loopTable=0)
			End if 
		End for 
	End if 
	
End if 