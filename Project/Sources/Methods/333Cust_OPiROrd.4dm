//%attributes = {"publishedWeb":true}
//Procedure: Cust_OPiROrd
//Noah Dykoski  April 20, 1999 / 11:55 PM
C_LONGINT:C283($1; $OrdRecNum)
$OrdRecNum:=$1

GOTO RECORD:C242([Order:3]; $OrdRecNum)
QUERY:C277([Invoice:26]; [Invoice:26]idNumOrder:1=[Order:3]idNum:2)
SELECTION TO ARRAY:C260([Invoice:26]; $aOPRRecID; [Invoice:26]idNum:2; $aOPRDocID; [Invoice:26]consignment:63; $aOPRStatus; [Invoice:26]datePaid:26; $aOPRDateEnd)
SELECTION TO ARRAY:C260([Invoice:26]dateDocument:35; $aOPRDateBeg; [Invoice:26]dateShipped:4; $aOPRNeed; [Invoice:26]total:18; $aOPRAmt; [Invoice:26]balanceDue:44; $aOPROpen)
SELECTION TO ARRAY:C260([Invoice:26]customerPO:29; $aOPRPO; [Invoice:26]attention:38; $aOPRAttn; [Invoice:26]repID:22; $aOPRRep; [Invoice:26]salesNameID:23; $aOPRSale)
SELECTION TO ARRAY:C260([Invoice:26]profile1:53; $aOPRPro1; [Invoice:26]profile2:66; $aOPRPro2; [Invoice:26]profile3:70; $aOPRPro3)
$k:=Records in selection:C76([Invoice:26])

For ($i; 1; $k)
	aOPRType{$i}:="IV"
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
CREATE SET:C116([Invoice:26]; "<>sOPiROrdIvcs")
UNLOAD RECORD:C212([Order:3])
UNLOAD RECORD:C212([Invoice:26])