//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/05/06, 21:36:16
// ----------------------------------------------------
// Method: Tm_SchdSetOpen
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_DATE:C307($1; vCalendarBegin)
If (Count parameters:C259<1)
	vCalendarBegin:=Current date:C33
Else 
	vCalendarBegin:=$1
End if 
//Procedure: Tm_SchdSetOpen
C_LONGINT:C283($i)
C_POINTER:C301($ptVar)
//C_DATE($1;$setDate)
//If (Count parameters=1)
//vCalendarBegin:=$1
//Else 
//End if 
If (<>prcControl=1)
	<>prcControl:=0
	Process_InitLocal
	WindowOpenTaskOffSets(0; 170; 180)
	ptCurTable:=(->[Base:1])
End if 
//vCalendarBegin:=Current date
ControlRecCheck
FORM SET INPUT:C55([Base:1]; "ScheduleSetter2")
ptCurTable:=(->[Base:1])
// calSupport:=File([Service])//to be used for mixing calanders between files
//ProcessTableOpen (->[Control];"skip")
MODIFY RECORD:C57([Base:1])


Process_ListActive
WO_FillArrays(0)
Tm_SchFillRays(0)
For ($i; 1; 11)
	$ptVar:=Get pointer:C304("vR"+String:C10($i))
	$ptVar->:=0
End for 
vL1:=0
vL2:=0
//
//