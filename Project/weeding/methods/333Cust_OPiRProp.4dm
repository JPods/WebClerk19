//%attributes = {"publishedWeb":true}
//Procedure: Cust_OPiRProp
//Noah Dykoski  April 20, 1999 / 11:45 PM
C_LONGINT:C283($1; $PropRecNum)
$PropRecNum:=$1

GOTO RECORD:C242([Proposal:42]; $PropRecNum)
QUERY:C277([Order:3]; [Order:3]proposalNum:79=[Proposal:42]idNum:5)
SELECTION TO ARRAY:C260([Order:3]; $aOPRRecID; [Order:3]idNum:2; $aOPRDocID; [Order:3]status:59; $aOPRStatus; [Order:3]dateInvoiceComp:6; $aOPRDateEnd)
SELECTION TO ARRAY:C260([Order:3]dateDocument:4; $aOPRDateBeg; [Order:3]dateNeeded:5; $aOPRNeed; [Order:3]total:27; $aOPRAmt; [Order:3]amountBackLog:54; $aOPROpen)
SELECTION TO ARRAY:C260([Order:3]customerPO:3; $aOPRPO; [Order:3]attention:44; $aOPRAttn; [Order:3]repID:8; $aOPRRep; [Order:3]salesNameID:10; $aOPRSale)
SELECTION TO ARRAY:C260([Order:3]profile1:61; $aOPRPro1; [Order:3]profile2:62; $aOPRPro2; [Order:3]profile3:63; $aOPRPro3)
$k:=Records in selection:C76([Order:3])
/////  CHOPPED  Cust_OPiRInitAr($k)
For ($i; 1; $k)
	aOPRType{$i}:="SO"
	aOPRDocID{$i}:=$aOPRDocID{$i}
	aOPRStatus{$i}:=$aOPRStatus{$i}
	aOPRDateBeg{$i}:=$aOPRDateBeg{$i}
	aOPRNeed{$i}:=$aOPRNeed{$i}
	aOPRDateEnd{$i}:=$aOPRDateEnd{$i}
	aOPRAmt{$i}:=$aOPRAmt{$i}
	aOPROpen{$i}:=$aOPROpen{$i}
	aOPRPO{$i}:=$aOPRPO{$i}
	aOPRAttn{$i}:=$aOPRAttn{$i}
	aOPRRep{$i}:=$aOPRRep{$i}
	aOPRSale{$i}:=$aOPRSale{$i}
	aOPRPro1{$i}:=$aOPRPro1{$i}
	aOPRPro2{$i}:=$aOPRPro2{$i}
	aOPRPro3{$i}:=$aOPRPro3{$i}
	aOPRRecID{$i}:=$aOPRRecID{$i}
End for 
CREATE SET:C116([Order:3]; "<>sOPiRPropOrds")
UNLOAD RECORD:C212([Proposal:42])
UNLOAD RECORD:C212([Order:3])