//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
//Procedure: Srch_FullDia

curTableNum:=Table:C252($1)
curTableNumAlt:=curTableNum
// jCenterWindow (870;590;5;"Query";"Wind_CloseBox")
// DIALOG([Default];"QueryEditor")
//DIALOG([control];"QueryEditor")
$winid:=Open form window:C675([Control:1]; "QueryEditor"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Control:1]; "QueryEditor")
CLOSE WINDOW:C154
viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)
MenuTitle