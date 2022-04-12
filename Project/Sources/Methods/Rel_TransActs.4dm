//%attributes = {"publishedWeb":true}

//Method: Rel_LedgerInvoices
C_LONGINT:C283($1; $doProcess)
If (count paramters=0)
	$doProcess:=0
Else 
	$doProcess:=$1
End if 
//
CREATE EMPTY SET:C140([DCash:62]; "$foundTrans")
$k:=Records in selection:C76([Ledger:30])
FIRST RECORD:C50([Ledger:30])
For ($i; 1; $k)
	QUERY:C277([DCash:62]; [DCash:62]DocApply:3=[Ledger:30]DocRefID:4; *)
	QUERY:C277([DCash:62];  & [DCash:62]TableApply:2=Abs:C99([Ledger:30]tableNum:3))
	CREATE SET:C116([DCash:62]; "$Current")
	UNION:C120("$Current"; "$foundTrans"; "$foundTrans")
	CLEAR SET:C117("$Current")
	//
	QUERY:C277([DCash:62]; [DCash:62]DocReceive:4=[Ledger:30]DocRefID:4; *)
	QUERY:C277([DCash:62];  & [DCash:62]TableReceive:8=Abs:C99([Ledger:30]tableNum:3))
	CREATE SET:C116([DCash:62]; "$Current")
	UNION:C120("$Current"; "$foundTrans"; "$foundTrans")
	CLEAR SET:C117("$Current")
	NEXT RECORD:C51([Ledger:30])
End for 
If ($doProcess=0)
	COPY SET:C600("$foundTrans"; "<>curSelSet")
	REDUCE SELECTION:C351([Ledger:30]; 0)
	<>ptCurTable:=(->[Ledger:30])
	<>prcControl:=0
	$title:=String:C10(Count user processes:C343)+Table name:C256(<>ptCurTable)
	<>processAlt:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; $title; Current process:C322)
	DELAY PROCESS:C323(Current process:C322; 60)
Else 
	USE SET:C118("$foundTrans")
End if 
CLEAR SET:C117("$foundTrans")