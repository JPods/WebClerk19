

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/24/18, 19:01:41
// ----------------------------------------------------
// Method: [Order].Input.Button1
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Is new record:C668([Customer:2]))
	TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Customer:2]adSource:62; 0; 1)
End if 
Data_ArchiveOld

// ### jwm ### 20171207_1106 updated [Contact]DateRetired
If ([Customer:2]dateRetired:111#Old:C35([Customer:2]dateRetired:111))
	AcceptContactsRetired
End if 
$unLoad:=False:C215
acceptFilePt($unLoad; ->[Customer:2]; ->[Contact:13]; ->[Service:6]; ->[Reference:7]; ->[CallReport:34])
acceptFilePt($unLoad; ->[OrderLine:49]; ->[Order:3]; ->[Invoice:26]; ->[Proposal:42]; ->[InvoiceLine:54])

If ([Customer:2]mfrLocationid:67<-1999999)
	$processNum:=New process:C317("setChMfgs"; <>tcPrsMemory; "ChoiceArray")
End if 
PathLoadFolder(->[Customer:2])
jReloadRecord

