//%attributes = {"publishedWeb":true}
//Procedure: Prs_PrcssAdd
C_LONGINT:C283(<>processAlt)
C_POINTER:C301(<>ptCurTable)
<>ptCurTable:=ptCurTable
<>processAlt:=New process:C317("Prs_AddRec"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptCurTable))