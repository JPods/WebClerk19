//%attributes = {"publishedWeb":true}
C_LONGINT:C283($0)
C_POINTER:C301($1; $2; $3; $4)
C_BOOLEAN:C305($5)
//pts -- contactFile;contactAcct;CustomerAcct;ContactPrime
If ($5)  //[Customer]Individual
	$0:=1
Else 
	QUERY:C277($1->; $2->=$3->; *)
	QUERY:C277($1->;  & $4->=True:C214)
	FIRST RECORD:C50($1->)
	$0:=Records in selection:C76($1->)
End if 