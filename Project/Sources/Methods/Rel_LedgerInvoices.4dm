//%attributes = {"publishedWeb":true}
//Method: Rel_LedgerInvoices
C_LONGINT:C283($1; $doProcess; $2; $theFile)
Case of 
	: (count paramters=0)
		$theFile:=26
		$doProcess:=0
	: (count paramters=1)
		$theFile:=$1
		$doProcess:=0
	Else 
		$theFile:=$1
		$doProcess:=$2
End case 
CREATE EMPTY SET:C140([Ledger:30]; "<>curSelSet")
If ($theFile=26)
	vi2:=Records in selection:C76([Invoice:26])
	FIRST RECORD:C50([Invoice:26])
	For (vi1; 1; vi2)
		QUERY:C277([Ledger:30]; [Ledger:30]tableNum:3=26; *)
		QUERY:C277([Ledger:30];  & [Ledger:30]DocRefID:4=[Invoice:26]invoiceNum:2)
		CREATE SET:C116([Ledger:30]; "Current")
		UNION:C120("Current"; "<>curSelSet"; "<>curSelSet")
		CLEAR SET:C117("Current")
		NEXT RECORD:C51([Invoice:26])
	End for 
Else 
	vi2:=Records in selection:C76([Payment:28])
	FIRST RECORD:C50([Payment:28])
	For (vi1; 1; vi2)
		QUERY:C277([Ledger:30]; [Ledger:30]tableNum:3=28; *)
		QUERY:C277([Ledger:30];  & [Ledger:30]DocRefID:4=[Payment:28]idUnique:8)
		CREATE SET:C116([Ledger:30]; "Current")
		UNION:C120("Current"; "<>curSelSet"; "<>curSelSet")
		CLEAR SET:C117("Current")
		NEXT RECORD:C51([Payment:28])
	End for 
End if 
If ($doProcess=0)
	REDUCE SELECTION:C351([Ledger:30]; 0)
	<>ptCurTable:=(->[Ledger:30])
	<>prcControl:=0
	vText1:=String:C10(Count user processes:C343)+Table name:C256(<>ptCurTable)
	<>processAlt:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; vText1; <>ptCurTable; Current process:C322; ""; 0; "")  //;<>ptCurTable)
	DELAY PROCESS:C323(Current process:C322; 60)
Else 
	USE SET:C118("<>curSelSet")
	CLEAR SET:C117("<>curSelSet")
End if 