//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-07T00:00:00, 20:57:41
// ----------------------------------------------------
// Method: Utility_FixUniqueID
// Description
// Modified: 12/07/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $countTables; $w; $protectedFieldNum; $tableNum; $createRecords; $Ndx; $RIS; $sourceCode)
C_TEXT:C284($thePrimary; $tableName)
C_POINTER:C301($ptTable; $ptField)

$sourceCode:=Num:C11(Not:C34(Is compiled mode:C492))


// Modified by: Bill James (2015-08-19T00:00:00 Setting UniqueIDs)



doShowImport:=0
$countTables:=Get last table number:C254
For ($tableNum; 1; $countTables)
	$tableName:=Table name:C256($tableNum)
	$ptTable:=Table:C252($tableNum)
	If ($tableName="zz@")
		READ WRITE:C146($ptTable->)
		// ### bj ### 20190924_2326
		// delete these records by intent, not during conversion
		// ALL RECORDS($ptTable->)
		// DELETE SELECTION($ptTable->)
	End if 
End for 




For ($tableNum; 1; $countTables)
	$tableName:=Table name:C256($tableNum)
	$ptTable:=Table:C252($tableNum)
	If (($ptTable#(->[QQQCounter:41])) & ($ptTable#(->[CounterPending:135])))
		$protectedFieldNum:=STR_GetUniqueFieldNum($tableName)
		If ($protectedFieldNum<1)
			If ($sourceCode=1)
				C_TEXT:C284($tableName)
				$tableName:=Table name:C256($tableNum)
				C_TEXT:C284($badName)
				$badName:=Char:C90(40)+"zz@"
				$badName:="(zz@"
				If ($tableName=$badName)
					
				End if 
				If (($tableName#"zz@") & ($tableName#$badName))  // "(zz"
					ALERT:C41("Table "+$tableName+" no primary field defined")
				End if 
			End if 
		Else 
			$ptField:=Field:C253($tableNum; $protectedFieldNum)
			REDUCE SELECTION:C351($ptTable->; 0)
			Case of 
				: (Type:C295($ptField->)=Is longint:K8:6)
					QUERY:C277($ptTable->; $ptField->=0)
				: (Type:C295($ptField->)=Is alpha field:K8:1)
					QUERY:C277($ptTable->; $ptField->="")
				: (Type:C295($ptField->)=Is integer:K8:5)
					QUERY:C277($ptTable->; $ptField->=0)
					ALERT:C41("Table "+$tableName+" is an Integer")
				Else 
					$tableName:=Table name:C256($tableNum)
					If (($tableName#"zz@") & ($tableName#(Char:C90(40)+"zz@")))  // "(zz"
						ALERT:C41("Table "+Table name:C256($tableNum)+" has no uniqueID")
					End if 
			End case 
			
			C_TEXT:C284($tableName)
			$tableName:=Table name:C256($tableNum)
			If ($tableName="zz@")
				// delete these records by intent, not during conversion
				// READ WRITE($ptTable->)
				// ALL RECORDS($ptTable->)
				// DELETE SELECTION($ptTable->)
			Else 
				$RIS:=Records in selection:C76($ptTable->)
				If ($RIS>0)
					
					READ WRITE:C146($ptTable->)
					For ($Ndx; 1; $RIS)
						GOTO SELECTED RECORD:C245($ptTable->; $Ndx)
						$thePrimary:=IEA_SaveRecord($ptTable; 1)  //;$newRecord;$doSave)
						SAVE RECORD:C53($ptTable->)
					End for 
					UNLOAD RECORD:C212($ptTable->)
				End if 
			End if 
		End if 
	End if 
End for 


READ WRITE:C146([InvoiceLine:54])
QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idUnique:47=0)
vi2:=Records in selection:C76([InvoiceLine:54])
FIRST RECORD:C50([InvoiceLine:54])
For (vi1; 1; vi2)
	
	SAVE RECORD:C53([InvoiceLine:54])
	NEXT RECORD:C51([InvoiceLine:54])
End for 


