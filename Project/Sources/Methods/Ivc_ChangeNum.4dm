//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/12/18, 13:12:56
// ----------------------------------------------------
// Method: Ivc_ChangeNum
// Description
// 
//
// Parameters
// ----------------------------------------------------


ALL RECORDS:C47([Invoice:26])
FIRST RECORD:C50([Invoice:26])
ALL RECORDS:C47([Ledger:30])
REDUCE SELECTION:C351([Ledger:30]; 2)
If (Record number:C243([Invoice:26])>-1)
	READ WRITE:C146([Ledger:30])
	$oldInv:=Old:C35([Invoice:26]invoiceNum:2)
	If ($oldInv#0)
		QUERY:C277([Ledger:30]; [Ledger:30]tableNum:3=Table:C252(->[Invoice:26]); *)
		QUERY:C277([Ledger:30];  & [Ledger:30]DocRefID:4=$oldInv)
		ConsolidateAccountID(->[Ledger:30]DocRefID:4; ->$oldInv)
	End if 
	READ ONLY:C145([Ledger:30])
End if 