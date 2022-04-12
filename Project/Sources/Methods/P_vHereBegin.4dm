//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 11/17/13, 22:46:39
// ----------------------------------------------------
// Method: P_vHereBegin
// Description
// 
//
// Parameters
// ----------------------------------------------------

rptRecNum:=-1
printAll:=True:C214  //need if preview is used  January 20, 1996
rptRecNum:=Record number:C243(ptCurTable->)
CREATE SET:C116(ptCurTable->; "P_Current")
ONE RECORD SELECT:C189(ptCurTable->)
printAll:=False:C215
C_LONGINT:C283(vlCurrentPage)
vlCurrentPage:=FORM Get current page:C276
