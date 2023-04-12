//%attributes = {"publishedWeb":true}

//KeyModifierCurrent
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Time Card")
//
<>ptCurTable:=ptCurTable
C_LONGINT:C283(<>prcCntrlNum)
Case of 
	: (ptCurTable=(->[Order:3]))
		<>prcCntrlNum:=[Order:3]idNum:2
	: (ptCurTable=(->[Service:6]))
		<>prcCntrlNum:=[Service:6]idNumOrder:22
	: ((ptCurTable=(->[Invoice:26])) & ([Invoice:26]idNumOrder:1#1))
		<>prcCntrlNum:=[Invoice:26]idNumOrder:1
	Else 
		<>prcCntrlNum:=0
End case 
//
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	<>processAlt:=New process:C317("TC_LaunchWindow"; <>tcPrsMemory; "Time Card")
End if 