//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/11/06, 12:31:21
// ----------------------------------------------------
// Method: Sched_Reset
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Count parameters:C259=1)
	$doThisAction:=$1
	C_LONGINT:C283($1)
Else 
	$doThisAction:=100
	//TRACE
End if 
If (((b21=1) | ($doThisAction=1) | ($doThisAction=100)) & (vDate1#!00-00-00!))
	$dtBegin:=DateTime_DTTo(vDate1; ?00:00:00?)
	$dtEnd:=DateTime_DTTo(vDate1; ?23:59:59?)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtAction:5>=$dtBegin; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$dtEnd; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=aName1{aName1})
	//
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	REDUCE SELECTION:C351([WorkOrder:66]; 0)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg1; ->aTimeSlotEnd1; ->aTimeSlotType1; ->aTimeSlotWhat1; ->aTimeSlotAction1; ->aTimeSlotWORec1; eTimeList1; ->vText1; vDate1)
	
End if 
If (((b22=1) | ($doThisAction=2) | ($doThisAction=100)) & (vDate2#!00-00-00!))
	$dtBegin:=DateTime_DTTo(vDate2; ?00:00:00?)
	$dtEnd:=DateTime_DTTo(vDate2; ?23:59:59?)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtAction:5>=$dtBegin; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$dtEnd; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=aName2{aName2})
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg2; ->aTimeSlotEnd2; ->aTimeSlotType2; ->aTimeSlotWhat2; ->aTimeSlotAction2; ->aTimeSlotWORec2; eTimeList2; ->vText2; vDate2)
	
End if 
If (((b23=1) | ($doThisAction=3) | ($doThisAction=100)) & (vDate1#!00-00-00!))
	$dtBegin:=DateTime_DTTo(vDate3; ?00:00:00?)
	$dtEnd:=DateTime_DTTo(vDate3; ?23:59:59?)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtAction:5>=$dtBegin; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$dtEnd; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=aName3{aName3})
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg3; ->aTimeSlotEnd3; ->aTimeSlotType3; ->aTimeSlotWhat3; ->aTimeSlotAction3; ->aTimeSlotWORec3; eTimeList3; ->vText3; vDate3)
End if 
If (((b24=1) | ($doThisAction=4) | ($doThisAction=100)) & (vDate4#!00-00-00!))
	$dtBegin:=DateTime_DTTo(vDate4; ?00:00:00?)
	$dtEnd:=DateTime_DTTo(vDate4; ?23:59:59?)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtAction:5>=$dtBegin; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$dtEnd; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=aName4{aName4})
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg4; ->aTimeSlotEnd4; ->aTimeSlotType4; ->aTimeSlotWhat4; ->aTimeSlotAction4; ->aTimeSlotWORec4; eTimeList4; ->vText4; vDate4)
	
End if 
If (((b25=1) | ($doThisAction=5) | ($doThisAction=100)) & (vDate5#!00-00-00!))
	$dtBegin:=DateTime_DTTo(vDate5; ?00:00:00?)
	$dtEnd:=DateTime_DTTo(vDate5; ?23:59:59?)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtAction:5>=$dtBegin; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$dtEnd; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=aName5{aName5})
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg5; ->aTimeSlotEnd5; ->aTimeSlotType5; ->aTimeSlotWhat5; ->aTimeSlotAction5; ->aTimeSlotWORec5; eTimeList5; ->vText5; vDate5)
	
End if 
If (eCntWos>0)
	//  --  CHOPPED  AL_UpdateArrays(eCntWos; -2)
	WO_ColorNameID
End if 