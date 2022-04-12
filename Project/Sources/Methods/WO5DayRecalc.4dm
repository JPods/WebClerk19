//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/26/06, 18:06:46
// ----------------------------------------------------
// Method: WO5DayRecalc
// Description
// 
//
// Parameters
// ----------------------------------------------------
//ScheduleSetter Script: b5
TRACE:C157
If ((vText1#"") & (vDate1#!00-00-00!))
	b21:=1
	Case of 
		: (Find in array:C230(<>aActivities; vText1)>-0)
			Sch_FillActivit(->vText1; vDate1)
		: (Find in array:C230(<>aNameID; vText1)>-0)
			Sch_FillNameID(->vText1; vDate1)
	End case 
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	REDUCE SELECTION:C351([WorkOrder:66]; 0)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg1; ->aTimeSlotEnd1; ->aTimeSlotType1; ->aTimeSlotWhat1; ->aTimeSlotAction1; ->aTimeSlotWORec1; eTimeList1; ->vText1; vDate1)
Else 
	BEEP:C151
End if 
If ((vText2#"") & (vDate2#!00-00-00!))
	b22:=1
	b21:=0
	Case of 
		: (Find in array:C230(<>aActivities; vText2)>-0)
			Sch_FillActivit(->vText2; vDate2)
		: (Find in array:C230(<>aNameID; vText2)>-0)
			Sch_FillNameID(->vText2; vDate2)
	End case 
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg2; ->aTimeSlotEnd2; ->aTimeSlotType2; ->aTimeSlotWhat2; ->aTimeSlotAction2; ->aTimeSlotWORec2; eTimeList2; ->vText2; vDate2)
Else 
	BEEP:C151
End if 
If ((vText3#"") & (vDate3#!00-00-00!))
	b23:=1
	b22:=0
	Case of 
		: (Find in array:C230(<>aActivities; vText3)>-0)
			Sch_FillActivit(->vText3; vDate3)
		: (Find in array:C230(<>aNameID; vText3)>-0)
			Sch_FillNameID(->vText3; vDate3)
	End case 
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg3; ->aTimeSlotEnd3; ->aTimeSlotType3; ->aTimeSlotWhat3; ->aTimeSlotAction3; ->aTimeSlotWORec3; eTimeList3; ->vText3; vDate3)
Else 
	BEEP:C151
End if 
If ((vText4#"") & (vDate4#!00-00-00!))
	b24:=1
	b23:=0
	Case of 
		: (Find in array:C230(<>aActivities; vText4)>-0)
			Sch_FillActivit(->vText4; vDate4)
		: (Find in array:C230(<>aNameID; vText4)>-0)
			Sch_FillNameID(->vText4; vDate4)
	End case 
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg4; ->aTimeSlotEnd4; ->aTimeSlotType4; ->aTimeSlotWhat4; ->aTimeSlotAction4; ->aTimeSlotWORec4; eTimeList4; ->vText4; vDate4)
Else 
	BEEP:C151
End if 
If ((vText5#"") & (vDate5#!00-00-00!))
	b24:=1
	b23:=0
	Case of 
		: (Find in array:C230(<>aActivities; vText5)>-0)
			Sch_FillActivit(->vText4; vDate5)
		: (Find in array:C230(<>aNameID; vText5)>-0)
			Sch_FillNameID(->vText4; vDate5)
	End case 
	$k:=Records in selection:C76([WorkOrder:66])
	WO_FillArrays($k)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	Tm_Wo2Time(->aTimeSlotBeg5; ->aTimeSlotEnd5; ->aTimeSlotType5; ->aTimeSlotWhat5; ->aTimeSlotAction5; ->aTimeSlotWORec5; eTimeList5; ->vText5; vDate5)
Else 
	BEEP:C151
End if 
b21:=1
b24:=0