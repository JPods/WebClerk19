//%attributes = {"publishedWeb":true}
//Procedure: setChTerms
var $conditions_ent : Object
var $conditions_c : Collection
ARRAY TEXT:C222(<>aContractDetail; 0)
$conditions_ent:=ds:C1482.ContractDetail.query("active = true")
$conditions_c:=$conditions_ent.toCollection("name")
$conditions_c:=$conditions_c.distinct()
COLLECTION TO ARRAY:C1562($conditions_c; <>aContractDetail; "name")
INSERT IN ARRAY:C227(<>aContractDetail; 1; 1)
<>aContractDetail{1}:="contractDetail"




READ ONLY:C145([Term:37])
ALL RECORDS:C47([Term:37])
C_LONGINT:C283($incRec; $cntRec)
$conRec:=Records in selection:C76([Term:37])
ARRAY TEXT:C222(<>aTerms; $conRec)
ARRAY TEXT:C222(<>aTermDesc; $conRec)
ARRAY LONGINT:C221(<>aTermDueDay; $conRec)
ARRAY LONGINT:C221(<>aTermDctDay; $conRec)
ARRAY REAL:C219(<>aTermDctRt; $conRec)
ARRAY DATE:C224(<>aTermDate; $conRec)

ARRAY LONGINT:C221(<>aTermType; $conRec)
//ARRAY LONGINT(<>aTermPrds;$conRec)
ARRAY LONGINT:C221(<>aTermPrdCnt; $conRec)
ARRAY LONGINT:C221(<>aTermPrdLen; $conRec)
ARRAY LONGINT:C221(<>aTermDCutOf; $conRec)
ARRAY LONGINT:C221(<>aTermDCutDu; $conRec)
//
//CREATE SET([Term];"Current")
FIRST RECORD:C50([Term:37])
For ($incRec; 1; $conRec)
	<>aTerms{$incRec}:=[Term:37]termID:1
	<>aTermDesc{$incRec}:=[Term:37]description:2
	If ([Term:37]dateBegin:8#!00-00-00!)  //&([Term]DaysInPeriod=0)&([Term]DueDays=0))
		<>aTermDueDay{$incRec}:=[Term:37]dateBegin:8-Current date:C33
		<>aTermType{$incRec}:=1
	Else 
		<>aTermType{$incRec}:=0
		<>aTermDueDay{$incRec}:=[Term:37]dueDays:3
	End if 
	<>aTermDctDay{$incRec}:=[Term:37]discountDays:5
	<>aTermDctRt{$incRec}:=[Term:37]discountRate:4
	<>aTermDate{$incRec}:=[Term:37]dateBegin:8
	<>aTermPrdCnt{$incRec}:=[Term:37]numOfPeriods:10
	
	<>aTermPrdLen{$incRec}:=[Term:37]daysInPeriod:9
	
	<>aTermDCutOf{$incRec}:=[Term:37]cutOffInv:11
	<>aTermDCutDu{$incRec}:=[Term:37]cutOffDue:12
	NEXT RECORD:C51([Term:37])
End for 
//SELECTION TO ARRAY([Term]termID;<>aTerms;[Term]Description;<>aTermDesc;[Term]DueDays;<>aTermDueDay;[Term]DiscountDays;<>aTermDctDay;[Term]DiscountRate;<>aTermDctRt;[Term]DateBegin;<>aTermDate;[Term]NumOfPeriods;<>aTermPrdCnt;[Term]DaysInPeriod;<>aTermPrdLen;[Term]CutOffInv;<>aTermDCutOf;[Term]CutOffDue;<>aTermDCutDu)
SORT ARRAY:C229(<>aTerms; <>aTermDesc; <>aTermDueDay; <>aTermDctDay; <>aTermDctRt; <>aTermDate; <>aTermPrdCnt; <>aTermPrdLen; <>aTermDCutOf; <>aTermDCutDu; <>aTermType)
INSERT IN ARRAY:C227(<>aTerms; 1; 1)
<>aTerms{1}:="Term"
<>aTerms:=1
INSERT IN ARRAY:C227(<>aTermDesc; 1; 1)
INSERT IN ARRAY:C227(<>aTermDueDay; 1; 1)
INSERT IN ARRAY:C227(<>aTermDctDay; 1; 1)
INSERT IN ARRAY:C227(<>aTermDctRt; 1; 1)
INSERT IN ARRAY:C227(<>aTermDate; 1; 1)
INSERT IN ARRAY:C227(<>aTermType; 1; 1)
//INSERT ELEMENT(<>aTermPrds;1;1)
INSERT IN ARRAY:C227(<>aTermPrdCnt; 1; 1)
INSERT IN ARRAY:C227(<>aTermPrdLen; 1; 1)
INSERT IN ARRAY:C227(<>aTermDCutOf; 1; 1)
INSERT IN ARRAY:C227(<>aTermDCutDu; 1; 1)
READ WRITE:C146([Term:37])
//USE SET("Current")
//CLEAR SET("Current")
UNLOAD RECORD:C212([Term:37])

REDUCE SELECTION:C351([Term:37]; 0)

