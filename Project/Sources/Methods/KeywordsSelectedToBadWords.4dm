//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-09-13T00:00:00, 10:15:39
// ----------------------------------------------------
// Method: KeywordsSelectedToBadWords
// Description
// Modified: 09/13/13
// 
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($p; $i; $k)
C_TEXT:C284($newBadWords; $1; $badWordList)

If (Count parameters:C259=0)
	$badWordList:="BadwordsTechNotes"
Else 
	$badWordList:=$1
End if 
UNLOAD RECORD:C212([Word:99])
QUERY:C277([TallyResult:73]; [TallyResult:73]Name:1=$badWordList; *)
QUERY:C277([TallyResult:73];  & [TallyResult:73]Purpose:2="Admin")
If (Records in selection:C76([TallyResult:73])=0)
	CREATE RECORD:C68([TallyResult:73])
	
	[TallyResult:73]Name:1:=$badWordList
	[TallyResult:73]Purpose:2:="Admin"
	[TallyResult:73]TextBlk1:5:="of,this,that,a,when,where,because"
End if 
[TallyResult:73]TextBlk1:5:=[TallyResult:73]TextBlk1:5+$newBadWords
SAVE RECORD:C53([TallyResult:73])
UNLOAD RECORD:C212([TallyResult:73])

If ($badWordList="BadwordsTechNotes")
	ARRAY TEXT:C222(aBadWords; 0)
	Key_BadWords("BadwordsTechNotes")
End if 