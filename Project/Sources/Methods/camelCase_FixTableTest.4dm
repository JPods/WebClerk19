//%attributes = {}
C_TEXT:C284($tableName; $vtReport; $vtCurrent; $vtBefore)
ARRAY TEXT:C222($aTables; 0)
C_OBJECT:C1216($obRec; $obSel)
$obSel:=ds:C1482.TallyResult.query("name=TableNames")
If ($obSel.length=0)
	$obRec:=ds:C1482.TallyResult.new()
	$obRec.name:="TableNames"
	$obRec.textBlk1:=Get text from pasteboard:C524
	$result_o:=$obRec.save()
Else 
	$obRec:=$obSel.first()
End if 
$vtTables:=$obRec.textBlk1
$vtReport:=$vtReport+"172"+"\t"+"Project"+"\t"+"Manipulated"+"\r"

var $c : Collection
$c:=Split string:C1554($response; ";")
COLLECTION TO ARRAY:C1562($c; $aTables)

C_LONGINT:C283($incTable; $cntTable)
$cntTable:=Get last table number:C254
For ($incTable; 1; $cntTable)
	$vtBefore:=$aTables{$incTable}
	$vtCurrent:=Table name:C256($incTable)
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
			$tableName:=$vtBefore
	End case 
	$vtReport:=$vtReport+$vtBefore+"\t"+$vtCurrent+"\t"+$tableName+"\r"
End for 
SET TEXT TO PASTEBOARD:C523($vtReport)
TRACE:C157

