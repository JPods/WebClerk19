//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/04/19, 17:08:30
// ----------------------------------------------------
// Method: AcceptPostAction
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptCurTable)

//ADDED BY AZM ON 2019-03-26, SO PREVENTING LOSING USER SELECTION OF TALLYMASTERS WHEN RETURNING FROM INPUT LAYOUT TO OUTPUT LAYOUT

C_BOOLEAN:C305($vbRestoreOldSet)
$vbRestoreOldSet:=False:C215

If (ptCurTable=(->[TallyMaster:60]))
	CREATE SET:C116([TallyMaster:60]; "UserSelectionOfTallyMasters")
	$vbRestoreOldSet:=True:C214
End if 

QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="AcceptPostTask"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252($1); *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Publish:25>0)
ARRAY TEXT:C222($scriptsPostAccept; 0)

C_LONGINT:C283($countTM; $incTM; $countTests)
$countTM:=Records in selection:C76([TallyMaster:60])
If ($countTM>0)
	ORDER BY:C49([TallyMaster:60]; [TallyMaster:60]Sequence:36)
	FIRST RECORD:C50([TallyMaster:60])
	For ($incTM; 1; $countTM)
		If ([TallyMaster:60]Script:9#"")
			APPEND TO ARRAY:C911($scriptsPostAccept; [TallyMaster:60]Script:9)
		End if 
		NEXT RECORD:C51([TallyMaster:60])
	End for 
End if 
vResponse:=""
REDUCE SELECTION:C351([TallyMaster:60]; 0)
myOK:=1  // set so the sequence of tests could be approved and dropped out without running all
$countTests:=Size of array:C274($scriptsPostAccept)
booAccept:=True:C214  // set values that can end the execution
myOK:=1
For ($incTM; 1; $countTests)
	If ((booAccept) & (myOK=1))
		ExecuteText(0; $scriptsPostAccept{$incTM})
		If ((myOK=0) | (booAccept=False:C215))
			$incTM:=$countTests
		End if 
	End if 
End for 

//ADDED BY AZM ON 2019-03-26, SO PREVENTING LOSING USER SELECTION OF TALLYMASTERS WHEN RETURNING FROM INPUT LAYOUT TO OUTPUT LAYOUT

If ($vbRestoreOldSet)
	USE SET:C118("UserSelectionOfTallyMasters")
End if 