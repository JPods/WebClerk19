//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: RelateByNumbers
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//
TRACE:C157
C_LONGINT:C283($1; $myTableNum)
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([Word:99])
If ($k>0)
	<>ptCurTable:=(->[Word:99])
	CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
	UNLOAD RECORD:C212(<>ptCurTable->)
	<>processAlt:=New process:C317("RelatedByNumberPrs"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptCurTable))
End if 