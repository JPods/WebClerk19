//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 07/01/02
	//Who: Bill James
	//Description: Opt out emails
	VERSION_960
End if 

C_POINTER:C301($1; $ptTable; $ptOptOut)

C_TEXT:C284($2; $theTask)
$ptOptOut:=$1
C_LONGINT:C283($tableNum)
$tableNum:=Table:C252($1)
$ptTable:=Table:C252($tableNum)
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76($ptTable->)
Case of 
	: ($2="N")
		READ WRITE:C146($ptTable->)
		FIRST RECORD:C50($ptTable->)
		For ($i; 1; $ki)
			$ptOptOut->:="N"
			SAVE RECORD:C53($ptTable->)
			QUERY:C277([CallReport:34]; [CallReport:34]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([CallReport:34];  & [CallReport:34]tableNum:2=2; *)
			QUERY:C277([CallReport:34];  & [CallReport:34]profile1:26="OptIn"; *)
			If (Records in selection:C76([CallReport:34])>0)
				READ WRITE:C146([CallReport:34])
				DELETE SELECTION:C66([CallReport:34])
			End if 
			NEXT RECORD:C51([Contact:13])
		End for 
	: ($2="S")
		
		
End case 