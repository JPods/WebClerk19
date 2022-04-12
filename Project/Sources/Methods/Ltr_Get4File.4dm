//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/09/18, 15:20:04
// ----------------------------------------------------
// Method: Ltr_Get4File
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; viLetterTableNum)
ARRAY TEXT:C222(SRVarNames; 0)
ARRAY TEXT:C222(aLetters; 0)
ARRAY LONGINT:C221(aLettersRecs; 0)
viLetterTableNum:=$1
READ ONLY:C145([QQQLetter:20])
QUERY:C277([QQQLetter:20]; [QQQLetter:20]tableNum:8=$1; *)
QUERY:C277([QQQLetter:20];  & [QQQLetter:20]Active:7=True:C214)
ORDER BY:C49([QQQLetter:20]; [QQQLetter:20]Name:1)
SELECTION TO ARRAY:C260([QQQLetter:20]; aLettersRecs; [QQQLetter:20]Name:1; aLetters)
INSERT IN ARRAY:C227(aLetters; 1)
aLetters{1}:="Letters"
aLetters:=1
INSERT IN ARRAY:C227(aLettersRecs; 1)
aLettersRecs{1}:=-1
UNLOAD RECORD:C212([QQQLetter:20])
READ WRITE:C146([QQQLetter:20])
