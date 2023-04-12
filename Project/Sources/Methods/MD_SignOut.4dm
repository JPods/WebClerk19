//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-06-09T00:00:00, 09:51:06
// ----------------------------------------------------
// Method: MD_SignOut
// Description
// Modified: 06/09/13
// 
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Material Draw")
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
	<>processAlt:=New process:C317("MD_LaunchWindow"; <>tcPrsMemory; "Material Draw")
End if 