//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/22/21, 21:19:37
// ----------------------------------------------------
// Method: camelCase_TableNames
// Description
// Use to change TableName in scripts such as TallyMaster
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($obStore; $obClass; $obField; $obSel; $obRec)
C_LONGINT:C283($viFieldNum; $viLength)
C_LONGINT:C283($viFind)
C_COLLECTION:C1488($cTables)
C_TEXT:C284($tableName; $vtReport; $vtCurrent; $vtBefore; $vtEvaluating)
$obClass:=New object:C1471
$obSel:=New object:C1471
$obRec:=New object:C1471

C_LONGINT:C283($incTable; $cntTable)
$cntTable:=Get last table number:C254
For ($incTable; 1; $cntTable)
	$vtEvaluating:=Table name:C256($incTable)
	$obClass:=ds:C1482[$vtEvaluating].new().getDataClass()
	$obField:=$obClass.tableName
	If ($obField#Null:C1517)
		$obSel:=ds:C1482[$vtEvaluating].query("tableName # :1"; "")
		For each ($obRec; $obSel)
			$vtBefore:=$obRec.tableName
			$viLength:=Length:C16($vtBefore)
			
			Case of 
				: ($vtBefore="Items")
					$tableName:="Item"
				: ($vtBefore="UsageSummaries")
					$tableName:="UsageSummary"
				: ($vtBefore="Taxes")
					$tableName:="TaxJurisdiction"
				: ($vtBefore="TallySummaries")
					$tableName:="TallySummary"
				: ($vtBefore="ReferencesTable")
					$tableName:="Reference"
				: ($vtBefore="Processes")
					$tableName:="Process"
				: ($vtBefore="ItemSpecs")
					$tableName:="ItemSpec"
				: ($vtBefore="ItemSiteBuckets")
					$tableName:="ItemSiteBucket"
				: ($vtBefore="ItemSerials")
					$tableName:="ItemSerial"
				: ($vtBefore="ItemSerialActions")
					$tableName:="ItemSerialAction"
				: ($vtBefore="ItemsCarried")
					$tableName:="ItemCarried"
				: ($vtBefore="DocPaths")
					$tableName:="Document"
				: ($vtBefore="Currencies")
					$tableName:="Currency"
				: ($vtBefore="QACustomers")
					$tableName:="QA"
				: ($vtBefore="Emails")
					$tableName:="Message"
				: ($vtBefore="Emails")
					$tableName:="Message"
				: ($vtBefore="Territories")
					$tableName:="Territory"
				: ($vtBefore="TermsAndConditions")
					$tableName:="ContractTerm"
				: ($vtBefore="CustomersSalesXRef")
					$tableName:="CustomerXRef"
				: ($vtBefore[[$viLength]]="s")
					$tableName:=Substring:C12($vtBefore; 1; $viLength-1)
				Else 
					$viFind:=Find in array:C230(<>aTableNames; $vtBefore)
					If ($viFind>0)
						$tableName:=$vtBefore
					Else 
						$tableName:=""
					End if 
			End case 
			$obRec.tableName:=$tableName
			$result_o:=$obRec.save()
		End for each 
	End if 
End for 




// 
// $cTables:=$obStore.toCollection()
// For each ($obClass; $cTables)
// $obField:=$obClass.tableName
// If ($obField#Null)
// $obSel:=ds[$obClass.name].query("tableName # :1"; "")
// For each ($obRec; $obSel)
// $tableName:=$obRec.tableName
// $viLength:=Length($tableName
// If ($tableName[[$viLength]]="s")
// 
// 
// End if 
// End for each 
// End if 
// End for each 

