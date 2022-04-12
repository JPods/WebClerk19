//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/29/06, 04:01:45
// ----------------------------------------------------
// Method: ExecuteArrayBuild
// Description
// 
//
// Parameters
// ----------------------------------------------------
ARRAY TEXT:C222(<>aExecuteScripts; 0)
ARRAY TEXT:C222(<>aExecuteNames; 0)
ARRAY LONGINT:C221(<>aExecuteTable; 0)
QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="ExecuteArray")
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Publish:25>0)
SELECTION TO ARRAY:C260([TallyMaster:60]Name:8; <>aExecuteNames; [TallyMaster:60]Script:9; <>aExecuteScripts; [TallyMaster:60]tableNum:1; <>aExecuteTable)
$cntRay:=Get last table number:C254
ARRAY TEXT:C222(<>aAcceptTest; $cntRay)
C_LONGINT:C283($incRay; $cntRay)
For ($incRay; 1; $cntRay)
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="AcceptTest"; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=$incRay; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Publish:25>0)
	Case of 
		: (Records in selection:C76([TallyMaster:60])=1)
			<>aAcceptTest{$incRay}:=[TallyMaster:60]Script:9
		: (Records in selection:C76([TallyMaster:60])=0)
			<>aAcceptTest{$incRay}:=""
		: (Records in selection:C76([TallyMaster:60])>0)
			FIRST RECORD:C50([TallyMaster:60])
			<>aAcceptTest{$incRay}:=[TallyMaster:60]Script:9
			Repeat 
				NEXT RECORD:C51([TallyMaster:60])
				$theRecNum:=Record number:C243([TallyMaster:60])
				If ($theRecNum>-1)
					If (Position:C15("-ErrDup"; [TallyMaster:60]Name:8)<1)
						[TallyMaster:60]Name:8:=[TallyMaster:60]Name:8+"-ErrDup"
						SAVE RECORD:C53([TallyMaster:60])
					End if 
				End if 
			Until ($theRecNum<0)
	End case 
End for 
REDUCE SELECTION:C351([TallyMaster:60]; 0)







