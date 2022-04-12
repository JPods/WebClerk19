//%attributes = {"publishedWeb":true}
//Procedure: Ledger_InvSet
C_LONGINT:C283($i; $k)
QUERY:C277([Invoice:26])
$k:=Records in selection:C76([Invoice:26])
FIRST RECORD:C50([Invoice:26])
For ($i; 1; $k)
	Ledger_InvSave
	NEXT RECORD:C51([Invoice:26])
End for 