//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 07/01/02
	//Who: Bill James
	//Description: Opt out emails
	VERSION_960
End if 

C_TEXT:C284($1; $theKey)
$theKey:=$1
C_LONGINT:C283($2; $tableNum)
$tableNum:=$2
C_TEXT:C284($3; $theOptID)
$theOptID:=$3
C_TEXT:C284($4; $theAction)
$theAction:=$4
QUERY:C277([CallReport:34]; [CallReport:34]customerID:1=$theKey; *)
QUERY:C277([CallReport:34];  & [CallReport:34]tableNum:2=$tableNum; *)
QUERY:C277([CallReport:34];  & [CallReport:34]profile1:26="OptIn"; *)
QUERY:C277([CallReport:34];  & [CallReport:34]profile2:27=$theOptID)
Case of 
	: ($theAction="clear all")
		If (Records in selection:C76([CallReport:34])>0)
			DELETE SELECTION:C66([CallReport:34])
		End if 
	: ($theAction="Add")
		Case of 
			: (Records in selection:C76([CallReport:34])=0)
				CREATE RECORD:C68([CallReport:34])
				
				[CallReport:34]customerID:1:=$theKey
				[CallReport:34]tableNum:2:=$tableNum
				[CallReport:34]profile1:26:="OptIn"
				[CallReport:34]profileName1:30:="Opt-In Acceptance"
				[CallReport:34]profileName2:31:="Specific Opt-In"
				[CallReport:34]profile2:27:=$theOptID
				SAVE RECORD:C53([CallReport:34])
			: (Records in selection:C76([CallReport:34])>1)
				REDUCE SELECTION:C351([CallReport:34]; Records in selection:C76([CallReport:34])-1)
				DELETE SELECTION:C66([CallReport:34])
				// Else //        (Records in selection([CallReport])=1)
				//no action
		End case 
End case 
