//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 11:51:42
// ----------------------------------------------------
// Method: PrintNoPrintSet2Zero
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


ALL RECORDS:C47([Item:4])
C_LONGINT:C283($cntTemp; $incTemp)
$cntTemp:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For ($incTemp; 1; $cntTemp)
	[Item:4]printNot:112:=0
	SAVE RECORD:C53([Item:4])
	NEXT RECORD:C51([Item:4])
End for 
//
READ WRITE:C146([InvoiceLine:54])
ALL RECORDS:C47([InvoiceLine:54])
$cntTemp:=Records in selection:C76([InvoiceLine:54])
FIRST RECORD:C50([InvoiceLine:54])
For ($incTemp; 1; $cntTemp)
	[InvoiceLine:54]printNot:52:=0
	SAVE RECORD:C53([InvoiceLine:54])
	NEXT RECORD:C51([InvoiceLine:54])
End for 
//
//
READ WRITE:C146([OrderLine:49])
ALL RECORDS:C47([OrderLine:49])
$cntTemp:=Records in selection:C76([OrderLine:49])
FIRST RECORD:C50([OrderLine:49])
For ($incTemp; 1; $cntTemp)
	[OrderLine:49]printNot:56:=0
	SAVE RECORD:C53([OrderLine:49])
	NEXT RECORD:C51([OrderLine:49])
End for 

READ WRITE:C146([ProposalLine:43])
ALL RECORDS:C47([ProposalLine:43])
$cntTemp:=Records in selection:C76([ProposalLine:43])
FIRST RECORD:C50([ProposalLine:43])
For ($incTemp; 1; $cntTemp)
	[ProposalLine:43]printNot:54:=0
	SAVE RECORD:C53([ProposalLine:43])
	NEXT RECORD:C51([ProposalLine:43])
End for 


