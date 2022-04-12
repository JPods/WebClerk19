//%attributes = {}
C_OBJECT:C1216($voTable; $voFields; $voFieldListByTable)
C_TEXT:C284($vtRole; $vtTables)
C_TEXT:C284($tableName; $vtFieldName)
C_TEXT:C284($vtFieldList; $vtFolderPath; $vtDocName)
C_LONGINT:C283($viSecureLvl)
C_TIME:C306($myDoc)

TRACE:C157

// some defaults for examples
$vtRole:="Sales"
$vtTables:="Customers,Contacts,Orders,OrderLines,Invoices,InvoiceLines,Payments,Ledgers,Items;Proposals;ProposalLines;RemoteUsers,Objectives,Projects,WorkOrders,QAQuestions,QAAnswers;QACustomers,Service"
$viSecureLvl:=5000
$vtQuery:="Role = :1 "

If (Count parameters:C259>0)
	$vtRole:=$1
	C_OBJECT:C1216($voFCs)
	C_TEXT:C284($vtQuery)
	$vtQuery:="Role = :1 "
	If (Count parameters:C259>1)
		$viSecureLvl:=$2
		$vtQuery:=$vtQuery+" AND SecurityLevel = :2 "
	End if 
End if 

CONFIRM:C162("Create role fields for role: "+$vtRole)
If (OK=1)
	If (Count parameters:C259>2)
		$vtTables:=$3
	Else 
		COPY ARRAY:C226(<>aTableNames; $aTableArray)
	End if 
	
	ARRAY TEXT:C222($aTableArray; 0)
	TextToArray($vtTables; ->$aTableArray; ",")
	
	C_LONGINT:C283($rayCnt)
	$rayCnt:=Size of array:C274($aTableArray)
	$voFieldListByTable:=New object:C1471
	For ($viCounterTables; 1; $rayCnt)
		If (Find in array:C230(<>aTableNames; $aTableArray{$viCounterTables})>0)
			$vtFieldList:=""
			$tableName:=<>aTableNames{$viCounterTables}
			$vtTableLC:=Lowercase:C14($tableName)
			$voFields:=<>voTables[$vtTableLC].fields
			For each ($voField; $voFields)
				If (($voFields[$voField].type#"") & ($voFields[$voField].type#"Object"))
					$vtFieldList:=$vtFieldList+$voFields[$voField].fieldName+","
				Else 
				End if 
			End for each 
			$vtFieldList:=Substring:C12($vtFieldList; 1; Length:C16($vtFieldList)-1)
			OB SET:C1220($voFieldListByTable; $tableName; $vtFieldList)
			//  $voFieldListByTable[$tableName]:=$vtFieldList
			If (Macintosh command down:C546)
				TRACE:C157
			End if 
		End if 
	End for 
End if 