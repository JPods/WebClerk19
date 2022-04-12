//%attributes = {"publishedWeb":true}
//Web_AddRec
C_LONGINT:C283($1)
If (Count parameters:C259=1)
	curTableNum:=$1
Else 
	curTableNum:=4
End if 
<>prcControl:=10  //skip asking for file    
<>ptCurTable:=Table:C252(curTableNum)
<>processAlt:=New process:C317("Prs_AddRec"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptCurTable))
Prs_ListActive