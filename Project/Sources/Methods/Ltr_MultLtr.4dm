//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/09/18, 18:59:25
// ----------------------------------------------------
// Method: Ltr_MultLtr
// Description
// 
//
// Parameters
// ----------------------------------------------------
// gqgqgq 
// TESTTHIS2018
TRACE:C157
ARRAY TEXT:C222(SRVarNames; 0)
ARRAY TEXT:C222(aLetters; 0)
ARRAY LONGINT:C221(aLettersRecs; 0)
Ltr_ListVars
SRPage:=1
P_InitPrintCnt
MESSAGES OFF:C175
<>aNameID:=Num:C11(Size of array:C274(<>aNameID)>0)
//clear so SignedBy is assigned
KeyModifierCurrent
Case of 
	: (OptKey=1)
		vi7:=-1
	: (CmdKey=1)
		vi7:=665
	Else 
		vi7:=0
End case 
READ ONLY:C145([QQQLetter:20])
Open window:C153(4; 40; 470; 434; -724; "Letter Editor"; "Wind_CloseBox")
//jCenterWindow (466;340;0)
DIALOG:C40([Control:1]; "LetterWrite")
CLOSE WINDOW:C154
READ WRITE:C146([QQQLetter:20])
SRPage:=1
P_InitPrintCnt
SRPage:=0
MESSAGES ON:C181
ARRAY TEXT:C222(SRVarNames; 0)
ARRAY TEXT:C222(aLetters; 0)
ARRAY LONGINT:C221(aLettersRecs; 0)
CLEAR VARIABLE:C89(stText1)
CLEAR VARIABLE:C89(stPict1)
