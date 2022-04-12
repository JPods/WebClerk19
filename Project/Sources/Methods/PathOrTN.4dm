//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/11/20, 11:32:15
// ----------------------------------------------------
// Method: PathOrTN
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $tableName; $vtTN; $0; $vtPath)
C_BOOLEAN:C305($vbisTN; $vbDoItems)
READ ONLY:C145([Item:4])
$tableName:=$1
$vbisTN:=(($2="1@") | ($2="t@"))
$vtPath:=<>webFolder+"images"+Folder separator:K24:12+"noimage.jpg"
Case of 
	: ($tableName="QACustomer")
		If ($vbisTN)
			$vtPath:=[QA:70]imagePathTn:24
		Else 
			$vtPath:=[QA:70]imagePath:19
		End if 
	: ($tableName="Document")
		If ($vbisTN)
			$vtPath:=[Document:100]pathTN:5
		Else 
			$vtPath:=[Document:100]path:4
		End if 
	: ($tableName="Item")
		$vbDoItems:=True:C214
	: ($tableName="OrderLine")
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
		$vbDoItems:=True:C214
	: ($tableName="ProposalLine")
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
		$vbDoItems:=True:C214
	: ($tableName="InvoiceLine")
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
		$vbDoItems:=True:C214
	: ($tableName="POLine")
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[POLine:40]itemNum:2)
		$vbDoItems:=True:C214
End case 
If ($vbDoItems)
	If ($vbisTN)
		$vtPath:=[Item:4]imagePathTn:114
	Else 
		$vtPath:=[Item:4]imagePath:104
	End if 
End if 

READ WRITE:C146([Item:4])

$0:=$vtPath